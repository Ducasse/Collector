"
I am a copy of class CCollectorEasyYAML. This comment is copied from there, and might not be entirely accurate

CCollectorEasy new importFromFileName:  '/Users/ducasse/Workspace/FirstCircle/Working/SF/sf/books.yml'


CCollectorEasy new import: '/Users/ducasse/Workspace/FirstCircle/Working/SF/sf/books.yml' asFileReference readStream contents



Banks, Iain :  
  books :
   - {title: ""La plage de verre"", read: no}
   - {title: ""Entrefer"", read: no}
   - {title: ""Trames"", read: yes, summary: ""une histoire de civilisation moyennageuse vivant dans un monde fait de mondes dans une planete fabriquees space opera"")}
   - {title: ""Une forme de guerre"", read: no}



Possible todo: 

	Could have serie complete validation by just adding a number of items

Aldiss, Brian :
  helliconia: 3
   - {title: ""Le printemps d'helliconia"", number: 1, read: no,  style: SF, price: 1}
   - {title: ""Helliconia, l'ete"", read: no, number: 2, style: SF, price: 1}
   - {title: ""L'hiver d'helliconia"", read: no, number: 3, style: SF, price: 1}
  books:
   - {title: ""L'instant de l'eclipse"", read: no,  style: fantaisie, price: 1}
"
Class {
	#name : #CCollectorDLittleImporter,
	#superclass : #Object,
	#instVars : [
		'mapper',
		'col'
	],
	#category : #'Collector-DLittle'
}

{ #category : #'as yet unclassified' }
CCollectorDLittleImporter class >> importFromFileName: aName [
	"self importFromFileName: '/Users/ducasse/Workspace/FirstCircle/Working/SF/sf/books.yml'  "
	^ self new import: aName asFileReference readStream contents; yourself
]

{ #category : #extracting }
CCollectorDLittleImporter >> bookFrom: aList [
	
	| book |
	book := CBookItem new.
	aList keysAndValuesDo: [ :k :v | 
		book 
			perform: (mapper selectorFor: k) asMutator
			with: (mapper convert: k value: v) ].
	^ book
]

{ #category : #mapper }
CCollectorDLittleImporter >> defaultMapper [

	| map |
	map := CMapper new.
	map convert: 'price' using: [ :each | each asNumber ].
	map convert: 'year' using: [ :each | each asNumber ].
	map convert: 'read' using: [ :each | each asLowercase = 'no' ifTrue: [ false ] ifFalse: [ true ] ].
	^ map

		
]

{ #category : #helpers }
CCollectorDLittleImporter >> extractAuthorFromString: aString [ 
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
CCollectorDLittleImporter >> extractSerieFrom: aList withAuthor: anAuthor [
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
CCollectorDLittleImporter >> fullBook: each authored: author [
	"Return a book from"
	| book |
	book := self bookFrom: each.
	book addAuthor: author.
	author addBook: book.
	^ book
]

{ #category : #importing }
CCollectorDLittleImporter >> import: aString [
	| list sum |
	list := DLittleLParser parse: aString.
	sum := list last.
	list removeFromRest: sum.
	
	list restDo: [ :b | 
		| author |
		author := self extractAuthorFromString: b value.
		b restDo: [ :aSerie | 
			self extractSerieFrom: aSerie withAuthor: author ]].
			
	self validateSumIsCorrect: sum value.
	
]

{ #category : #accessing }
CCollectorDLittleImporter >> importedCollection [

	^ col 
]

{ #category : #accessing }
CCollectorDLittleImporter >> importedItemSize [

	^ col size
]

{ #category : #initialization }
CCollectorDLittleImporter >> initialize [

	super initialize.
	col := CCollection new.
	self flag: #toLook. "We will have to decide if we use of not subclasses of CCollection"
	mapper := self defaultMapper
]

{ #category : #initialization }
CCollectorDLittleImporter >> mapper: aMapper [

	mapper := aMapper
]

{ #category : #importing }
CCollectorDLittleImporter >> validateSumIsCorrect: sum [

	^ col size = sum asNumber
		ifFalse: [ CImporterError new messageText: 'Expecting ', sum asString, ' but imported ', col size asString ; signal]
]
