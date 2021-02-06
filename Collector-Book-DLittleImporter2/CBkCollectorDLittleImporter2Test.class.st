Class {
	#name : #CBkCollectorDLittleImporter2Test,
	#superclass : #TestCase,
	#instVars : [
		'importer'
	],
	#category : #'Collector-Book-DLittleImporter2'
}

{ #category : #utils }
CBkCollectorDLittleImporter2Test >> importer [
	^ CBkCollectorDLittleImporter2 new
]

{ #category : #utils }
CBkCollectorDLittleImporter2Test >> parse: aText [

	^ DLittleLParser new parse: aText
]

{ #category : #running }
CBkCollectorDLittleImporter2Test >> setUp [ 
	super setUp.
	importer := self importer. 

]

{ #category : #'test - importing basic' }
CBkCollectorDLittleImporter2Test >> testImportEntity [
	| book |
	book := importer
		importFrom:
			(self
				parse:
					'(title : Les vents du changement (read : no) (style : SF) (price : 2.39))').
					
	self assert: book title equals: 'Les vents du changement'.
	self assert: book price equals: 2.39.
	self assert: book style equals: 'SF'.
	self deny: book read

]

{ #category : #'test - importing basic' }
CBkCollectorDLittleImporter2Test >> testImportKnownProperty [
	
	| book dl |
	dl := self parse: '(price : 2.39) (read : no) (style : SF))'.
	book := CBookItem newWith: 'Les vents du changement'.
	importer importPair: dl head for: book.					
	self assert: book price equals: 2.39.


]

{ #category : #'test - importing basic' }
CBkCollectorDLittleImporter2Test >> testImportProperties [
	
	| book dl |
	dl := self parse: '(empty : empty 
								(zork : 2.39) (read : no) (style : SF))'.
	book := CBookItem newWith: 'Les vents du changement'.
	importer importProperties: dl rest for: book.					
	self assert: (book propertyAt: #zork)  equals: '2.39'.
	self deny: book read.
	self assert: book style equals: 'SF'

]

{ #category : #'test - importing basic' }
CBkCollectorDLittleImporter2Test >> testImportUnknownProperty [
	
	| book dl |
	dl := self parse: '(zork : 2.39) (read : no) (style : SF))'.
	book := CBookItem newWith: 'Les vents du changement'.
	importer importPair: dl head for: book.					
	self assert: (book propertyAt: #zork)  equals: '2.39'.


]
