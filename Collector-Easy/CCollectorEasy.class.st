"
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
	#name : #CCollectorEasy,
	#superclass : #Object,
	#instVars : [
		'mapper',
		'col'
	],
	#category : #'Collector-Easy-Importer'
}

{ #category : #mapper }
CCollectorEasy >> defaultMapper [

	| map |
	map := CMapper new.
	map convert: 'price' using: [ :each | each asNumber ].
	map convert: 'read' using: [ :each | each asLowercase = 'no' ifTrue: [ false ] ifFalse: [ true ] ].
	^ map

		
]

{ #category : #extracting }
CCollectorEasy >> extractAuthor: aString [ 
	"Precondition: aSTring is either 'name' or 'name, first names"
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
CCollectorEasy >> extractBook: aDict [ 
	"Precondition: aSTring is either 'name' or 'name, first names"
	| book |
	book := CBookItem new.
	aDict keysAndValuesDo: [ :k :v | 
		book 
			perform: (mapper selectorFor: k) asMutator
			with: (mapper convert: k value: v) ].
	^ book
]

{ #category : #importing }
CCollectorEasy >> extractFullBook: each authored: author [
	| book |
	book := self extractBook: each.
	author addBook: book.
	^ book
]

{ #category : #importing }
CCollectorEasy >> import: yamlString [
	| yamlDicts sum |
	yamlDicts := PPYAMLGrammar parse: yamlString.
	sum := (yamlDicts at: 'sum') asString.
	yamlDicts removeKey: 'sum'.
	yamlDicts
		keysAndValuesDo: [ :anAuthorKey :aDictionary | 
			self treatAuthorNamed: anAuthorKey withData: aDictionary
			].
	self validateSumIsCorrect: sum.
	
]

{ #category : #importing }
CCollectorEasy >> importedCollection [

	^ col 
]

{ #category : #importing }
CCollectorEasy >> importedItemSize [

	^ col size
]

{ #category : #initialize }
CCollectorEasy >> initialize [

	super initialize.
	col := CCollection new.
	mapper := self defaultMapper
]

{ #category : #mapper }
CCollectorEasy >> mapper: aMapper [

	mapper := aMapper
]

{ #category : #importing }
CCollectorEasy >> treatAuthorNamed: anAuthorKey withData: aDictionary [
	| author bookSection |
	author := self extractAuthor: anAuthorKey.
	
	bookSection := (aDictionary at: 'books' ifAbsent: [#()]).
	bookSection
		do: [ :each | 
			| book |
			book := self extractFullBook: each authored: author.
			col add: book ].
	bookSection ifNotEmpty: [aDictionary removeKey: 'books'].
	
	aDictionary keysAndValuesDo: [ :aSerie :books | 
			
			| serie |
			serie := CSerieItem new name: aSerie. 
			books do: [ :each | 
				| book |
				book := self extractFullBook: each authored: author.
				serie add: book.
				book serie: serie.
				col add: book ].
	]
]

{ #category : #importing }
CCollectorEasy >> validateSumIsCorrect: sum [
	col size = sum asNumber
		ifFalse: [ CImporterError new messageText: 'Expecting ', sum asString, ' but imported ', col size asString ; signal]
]
