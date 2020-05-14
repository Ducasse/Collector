"
This is an old package for loading collection in Yaml crap.


CCollectorYAMLImporter new importFromFileName:  '/Users/ducasse/Workspace/FirstCircle/Working/SF/sf/books.yml'

CCollectorYAMLImporter new import: '/Users/ducasse/Workspace/FirstCircle/Working/SF/sf/books.yml' asFileReference readStream contents

Banks, Iain :  
  books :
   - {title: ""La plage de verre"", read: no}
   - {title: ""Entrefer"", read: no}
   - {title: ""Trames"", read: yes, summary: ""une histoire de civilisation moyennageuse vivant dans un monde fait de mondes dans une planete fabriquees space opera"")}
   - {title: ""Une forme de guerre"", read: no}


Possible todos: 
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
	#name : #CCollectorYAMLImporter,
	#superclass : #Object,
	#instVars : [
		'mapper',
		'col'
	],
	#category : #'Collector-Book-YAMLImporter-Importer'
}

{ #category : #'as yet unclassified' }
CCollectorYAMLImporter class >> importFromFileName: aName [
	"self importFromFileName: '/Users/ducasse/Workspace/FirstCircle/Working/SF/sf/books.yml'  "
	^ self new import: aName asFileReference readStream contents; yourself
]

{ #category : #mapper }
CCollectorYAMLImporter >> defaultMapper [

	| map |
	map := CMapper new.
	map convert: 'price' using: [ :each | each asNumber ].
	map convert: 'year' using: [ :each | each asNumber ].
	map convert: 'read' using: [ :each | each asLowercase = 'no' ifTrue: [ false ] ifFalse: [ true ] ].
	^ map

		
]

{ #category : #extracting }
CCollectorYAMLImporter >> extractAuthor: aString [ 
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
CCollectorYAMLImporter >> extractBook: aDict [ 
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
CCollectorYAMLImporter >> extractFullBook: each authored: author [
	| book |
	book := self extractBook: each.
	book addAuthor: author.
	author addBook: book.
	^ book
]

{ #category : #importing }
CCollectorYAMLImporter >> import: yamlString [
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
CCollectorYAMLImporter >> importedCollection [

	^ col 
]

{ #category : #importing }
CCollectorYAMLImporter >> importedItemSize [

	^ col size
]

{ #category : #initialize }
CCollectorYAMLImporter >> initialize [

	super initialize.
	col := CCollection new.
	mapper := self defaultMapper
]

{ #category : #mapper }
CCollectorYAMLImporter >> mapper: aMapper [

	mapper := aMapper
]

{ #category : #importing }
CCollectorYAMLImporter >> treatAuthorNamed: anAuthorKey withData: aDictionary [
	| author bookSection bookSerie |
	author := self extractAuthor: anAuthorKey.
	
	bookSection := (aDictionary at: 'books' ifAbsent: [#()]).
	bookSerie := CSerieItem new name: 'books'.
	bookSection
		do: [ :each | 
			| book |
			book := self extractFullBook: each authored: author.
			bookSerie add: book.
			book serie: bookSerie.
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
CCollectorYAMLImporter >> validateSumIsCorrect: sum [
	col size = sum asNumber
		ifFalse: [ CImporterError new messageText: 'Expecting ', sum asString, ' but imported ', col size asString ; signal]
]
