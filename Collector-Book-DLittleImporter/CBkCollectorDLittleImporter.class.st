"
I'm a dedicated importer for book collection. 
This is not really great in terms of reuse but this is a try to understand 
how this logic could be directed via a metamodel.

```
(CBkCollectorDLittleImporter new importFromFileName:  '/Users/ducasse/Workspace/FirstCircle/Working/SF/sf/books.dl')
```

```
CBkCollectorDLittleImporter new import: '/Users/ducasse/Workspace/FirstCircle/Working/SF/sf/books.dl' asFileReference readStream contents
```

```
(collection : SF
	(author : Aldiss, Brian 
		(serie : helliconia  
  	 		(title: Le printemps d''helliconia (read: no)  (style: SF) (price: 1))
  		 	(title: Helliconia, l''ete (read: no)  (style: SF) (price: 1))
 	 	 	(title: L''hiver d''helliconia (read: no)  (style: SF) (price: 1)))
 	 	(books : default
  	 	 	( title: L''instant de l''eclipse (read: no)  (style: fantaisie) (price: 1))))
)
```

# Notes for later. 
- the logic is strange because when importing a serie we require an author (`extractSerieFrom:withAuthor:`) while when importing a book we do not require a serie (`extractBook:`). 
- we do not support well books with two authors. 







"
Class {
	#name : #CBkCollectorDLittleImporter,
	#superclass : #Object,
	#instVars : [
		'mapper',
		'col'
	],
	#category : #'Collector-Book-DLittleImporter'
}

{ #category : #'instance creation' }
CBkCollectorDLittleImporter class >> importFromFileName: aName [
	"self importFromFileName: '/Users/ducasse/Workspace/FirstCircle/Working/SF/sf/books.yml'  "
	^ self new import: aName asFileReference readStream contents; yourself
]

{ #category : #extracting }
CBkCollectorDLittleImporter >> bookFrom: aList [
	"create a book from a book descrition, since it is nested in parent (serie or author)
	we do not set the author yet. 
	
	aList is in the form of 
		(title: H2G2 2 (read: no) (style: comic english humour) (price: 2))"
	
	
	| book |
	book := CBookItem new.
	aList keysAndValuesDo: [ :k :v | 
		book 
			perform: (mapper selectorFor: k) asMutator
			with: (mapper convert: k value: v) ].
	^ book
]

{ #category : #testing }
CBkCollectorDLittleImporter >> checkMethodExist: aSelector [ 
	^ self class canUnderstand: aSelector
]

{ #category : #importing }
CBkCollectorDLittleImporter >> convertAuthor: list [
	"list = (a:b (c:d) (e:f))
	for example
	
	(author : Aldiss, Brian 
		(serie : helliconia  
  	 		(title: Le printemps (read: no) (style: SF) (price: 1)))
 	 	(books : default
  	 	 	( title: Eclips (read: no) (style: fantaisie) (price: 1))))"
		
  | author |
  author := self extractAuthorEntityFromString: list value.
  list restDo: [ :aSerie |  self extractSerieFrom: aSerie withAuthor: author ]
]

{ #category : #importing }
CBkCollectorDLittleImporter >> convertTopLevelItems: list [
  "Here list = (
						(a:b (c:d) (e:f))
						(A:B (C:D) (E:F))
					), 
	we perform convertA:, converta: when methods are available,
	else raises an error"
	"we can do something more static one we will have a metamodel"
		
	list restDo: [:b | | sel | 
		sel := (#convert, b key capitalized , ':') asSymbol. 
		(self checkMethodExist: sel) 
				ifTrue: [self perform: sel with: b ]]
]

{ #category : #mapper }
CBkCollectorDLittleImporter >> defaultMapper [

	| map |
	map := CMapper new.
	map convert: 'price' using: [ :each | each asNumber ].
	map convert: 'year' using: [ :each | each asNumber ].
	map convert: 'read' using: [ :each | each asLowercase = 'no' ifTrue: [ false ] ifFalse: [ true ] ].
	^ map

		
]

{ #category : #helpers }
CBkCollectorDLittleImporter >> extractAuthorEntityFromString: aString [ 
	"Precondition: aString is either 'name' or 'name, first names"
	"Return an author does not add it to anything"
	| auth split |
	auth := CBookAuthor new.
	split := aString trimBoth splitOn: $,.
	split size = 2
		ifTrue: [ 
			auth name: split first trimRight. 
			auth firstName: split second trimLeft ]
		ifFalse: [ 
			auth name: aString trimBoth ].
	^ auth
]

{ #category : #extracting }
CBkCollectorDLittleImporter >> extractSerieFrom: aList withAuthor: anAuthor [
	"Create a serie and add all its books to the collection"
	
	| serie |
	serie := CBookSerie new name: aList value. 
	aList restDo: [ :each | 
			| book |
			book := self fullBook: each authored: anAuthor.
			serie add: book.
			book serie: serie.
			col add: book ]
	
]

{ #category : #extracting }
CBkCollectorDLittleImporter >> fullBook: each authored: author [
	"Return a book from"
	| book |
	book := self bookFrom: each.
	book addAuthor: author.
	^ book
]

{ #category : #importing }
CBkCollectorDLittleImporter >> import: aString [
	| list sum |
	list := DLittleLParser parse: aString.
	sum := list last.
	col name: list value.
	list removeFromRest: sum.
	self convertTopLevelItems: list.
	self validateSumIsCorrect: sum value
]

{ #category : #importing }
CBkCollectorDLittleImporter >> importFromFileName: afileName [

	| fileRef |
	fileRef := afileName asFileReference. 
	self import: fileRef readStream contents. 
]

{ #category : #accessing }
CBkCollectorDLittleImporter >> importedCollection [

	^ col 
]

{ #category : #accessing }
CBkCollectorDLittleImporter >> importedItemSize [

	^ col size
]

{ #category : #initialization }
CBkCollectorDLittleImporter >> initialize [

	super initialize.
	col := CCollection new.
	self flag: #toLook. "We will have to decide if we use of not subclasses of CCollection"
	mapper := self defaultMapper
]

{ #category : #initialization }
CBkCollectorDLittleImporter >> mapper: aMapper [

	mapper := aMapper
]

{ #category : #importing }
CBkCollectorDLittleImporter >> validateSumIsCorrect: sum [

	^ col size = sum asNumber
		ifFalse: [ CImporterError new messageText: 'Expecting ', sum asString, ' but imported ', col size asString ; signal]
]
