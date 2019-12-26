Class {
	#name : #CGmCollectorDLittleImporter,
	#superclass : #Object,
	#instVars : [
		'mapper',
		'col'
	],
	#category : #'Collector-Game-DLittleImporter'
}

{ #category : #'instance creation' }
CGmCollectorDLittleImporter class >> importFromFileName: aName [
	"self importFromFileName: '/Users/ducasse/Workspace/FirstCircle/Working/SF/sf/books.yml'  "
	^ self new import: aName asFileReference readStream contents; yourself
]

{ #category : #extracting }
CGmCollectorDLittleImporter >> bookFrom: aList [
	
	| book |
	book := CBookItem new.
	aList keysAndValuesDo: [ :k :v | 
		Transcript show: k asString ; cr.
		book 
			perform: (mapper selectorFor: k) asMutator
			with: (mapper convert: k value: v) ].
	^ book
]

{ #category : #testing }
CGmCollectorDLittleImporter >> checkMethodExist: aSelector [ 
	^ self class canUnderstand: aSelector
]

{ #category : #importing }
CGmCollectorDLittleImporter >> convertAuthor: list [
	"list = (a:b (c:d) (e:f))"
  | author |
  author := self extractAuthorFromString: list value.
  list restDo: [ :aSerie |  self extractSerieFrom: aSerie withAuthor: author ]
]

{ #category : #importing }
CGmCollectorDLittleImporter >> convertTopLevelItems: list [
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
CGmCollectorDLittleImporter >> defaultMapper [

	| map |
	map := CMapper new.
	map convert: 'price' using: [ :each | each asNumber ].
	map convert: 'year' using: [ :each | each asNumber ].
	map convert: 'read' using: [ :each | each asLowercase = 'no' ifTrue: [ false ] ifFalse: [ true ] ].
	^ map

		
]

{ #category : #helpers }
CGmCollectorDLittleImporter >> extractAuthorFromString: aString [ 
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
CGmCollectorDLittleImporter >> extractSerieFrom: aList withAuthor: anAuthor [
	"Create a serie and add all its books to the collection"
	
	| serie |
	serie := CSerieItem new name: aList value. 
	aList restDo: [ :each | 
			| book |
			book := self fullBook: each authored: anAuthor.
			serie add: book.
			book serie: serie.
			col add: book ]
	
]

{ #category : #extracting }
CGmCollectorDLittleImporter >> fullBook: each authored: author [
	"Return a book from"
	| book |
	book := self bookFrom: each.
	book addAuthor: author.
	author addBook: book.
	^ book
]

{ #category : #extracting }
CGmCollectorDLittleImporter >> gameFrom: aList [
	
	| book |
	book := CGameItem new.
	"class should be dtermined automatically"
	aList keysAndValuesDo: [ :k :v | 
		Transcript show: k asString ; cr.
		book 
			perform: (mapper selectorFor: k) asMutator
			with: (mapper convert: k value: v) ].
	^ book
]

{ #category : #importing }
CGmCollectorDLittleImporter >> import: aString [
	| list sum |
	list := DLittleLParser parse: aString.
	sum := list last.
	col name: list value.
	list removeFromRest: sum.
	self convertTopLevelItems: list.
	self validateSumIsCorrect: sum value
]

{ #category : #importing }
CGmCollectorDLittleImporter >> importFromFileName: afileName [

	| fileRef |
	fileRef := afileName asFileReference. 
	self import: fileRef readStream contents. 
]

{ #category : #accessing }
CGmCollectorDLittleImporter >> importedCollection [

	^ col 
]

{ #category : #accessing }
CGmCollectorDLittleImporter >> importedItemSize [

	^ col size
]

{ #category : #initialization }
CGmCollectorDLittleImporter >> initialize [

	super initialize.
	col := CCollection new.
	self flag: #toLook. "We will have to decide if we use of not subclasses of CCollection"
	mapper := self defaultMapper
]

{ #category : #initialization }
CGmCollectorDLittleImporter >> mapper: aMapper [

	mapper := aMapper
]

{ #category : #importing }
CGmCollectorDLittleImporter >> validateSumIsCorrect: sum [

	^ col size = sum asNumber
		ifFalse: [ CImporterError new messageText: 'Expecting ', sum asString, ' but imported ', col size asString ; signal]
]
