"
PPYAMLGrammar parse: '/Users/ducasse/Workspace/FirstCircle/Working/SF/sf/books.yml' asFileReference readStream contents
"
Class {
	#name : #CCollectorEasy,
	#superclass : #Object,
	#instVars : [
		'mapper'
	],
	#category : #'Collector-Easy-Importer'
}

{ #category : #mapper }
CCollectorEasy >> defaultMapper [

	| map |
	map := CMapper new.
	map convert: 'price' using: [ :each | each asNumber ].
	map convert: 'read' using: [ :each | each = 'No' ifTrue: [ false ] ifFalse: [ true ] ].

		
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
		book perform: k with: v ].
	^ book
]

{ #category : #importing }
CCollectorEasy >> import: yamlString [
	| col yamlDicts sum  |
	col := CCollection  new.
	yamlDicts := PPYAMLGrammar parse: yamlString.

	sum := (yamlDicts at: 'sum') asString.
	yamlDicts removeKey: 'sum'.
	yamlDicts keysAndValuesDo: [ :k :v | 
			| author |
			author := self extractAuthor: k.
			(v at: 'books') 
				do: [ :each | 
						| book |
						book := self extractBook: each.
						author addBook: book. 
						col add: book
						].
			v removeKey: 'books'.
			].
	^ col
	
	
]

{ #category : #mapper }
CCollectorEasy >> initialize [ 
	super initialize. 
	mapper := self defaultMapper.
]

{ #category : #mapper }
CCollectorEasy >> mapper: aMapper [

	mapper := aMapper
]
