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
	| book dl |
	dl := self parse: '(title : Les vents du changement (read : no) (style : SF) (price : 2.39))'.
	book := importer import: dl.
					
	self assert: book title equals: 'Les vents du changement'.
	self assert: book price equals: 2.39.
	self assert: book style equals: 'SF'.
	self deny: book read

]

{ #category : #'test - inmporting nested' }
CBkCollectorDLittleImporter2Test >> testImportEntityWithNestedEntityAndKnownProperties [
	| serie dl |
	dl := (self
				parse:
					'(series : la cour
						(title : la cours du chaos (read : no) (style : SF) (price : 2.39) (zorkzork : 1.3))
						(title : Les 9 princes d''ambre (read : no) (style : SF) (price : 2.3) )
						(complete : no)
						(finished : yes)
						(numberOfBooks : 5)
						)').
	serie := importer import: dl.

	"a Series got created. "
	self assert: serie name equals: 'la cour'.

	"the entities composing it got created too."
	self assert: serie items size equals: 2.
	self deny: serie complete.
	self assert: serie numberOfBooks equals: 5.
	self assert: serie finished.
	
]

{ #category : #'test - inmporting nested' }
CBkCollectorDLittleImporter2Test >> testImportEntityWithNestedEntityAndProperties [
	| serie dl |
	dl := (self
				parse:
					'(series : la cour
						(title : la cours du chaos (read : no) (style : SF) (price : 2.39) (zorkzork : 1.3))
						(title : Les 9 princes d''ambre (read : no) (style : SF) (price : 2.3) )
						(complete : true)
						)').
	serie := importer import: dl.

	"a Series got created. "
	self assert: serie name equals: 'la cour'.

	"the entities composing it got created too."
	self assert: serie items size equals: 2.
	self assert: serie complete
]

{ #category : #'test - importing basic' }
CBkCollectorDLittleImporter2Test >> testImportKnownProperty [
	
	| book dl |
	dl := self parse: '(price : 2.39) (read : no) (style : SF))'.
	book := CBookItem newWith: 'Les vents du changement'.
	importer importLeaf: dl head for: book.					
	self assert: book price equals: 2.39.


]

{ #category : #'test - inmporting nested' }
CBkCollectorDLittleImporter2Test >> testImportNestedEntity [
	| serie dl firstBook secondBook |
	dl := (self
				parse:
					'(series : la cour
						(title : la cours du chaos (read : no) (style : SF) (price : 2.39) (zorkzork : 1.3))
						(title : Les 9 princes d''ambre (read : no) (style : SF) (price : 2.3) )
						)').
	serie := importer import: dl.

	"a Series got created. "
	self assert: serie name equals: 'la cour'.

	"the entities composing it got created too."
	self assert: serie items size equals: 2.
	
	"we check that properties of nested entities are well handed too."
	firstBook := serie items first.
	self assert: firstBook title equals: 'la cours du chaos'.
	
	self assert: firstBook price equals: 2.39.
	self assert: firstBook style equals: 'SF'.
	self assert: (firstBook propertyAt: 'zorkzork') equals: '1.3'.
	
	secondBook := serie items second.
	self assert: secondBook title equals: 'Les 9 princes d''ambre'.
	
	self assert: secondBook price equals: 2.3.
	self assert: secondBook style equals: 'SF'.
	
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
	importer importLeaf: dl head for: book.					
	self assert: (book propertyAt: #zork)  equals: '2.39'.


]
