Class {
	#name : #CCollectorDLittleImporter2Test,
	#superclass : #TestCase,
	#instVars : [
		'importer'
	],
	#category : #'Collector-Book-DLittleImporter2'
}

{ #category : #utils }
CCollectorDLittleImporter2Test >> importer [
	^ CCollectorDLittleImporter2 new
]

{ #category : #utils }
CCollectorDLittleImporter2Test >> parse: aText [

	^ DLittleLParser new parse: aText
]

{ #category : #running }
CCollectorDLittleImporter2Test >> setUp [ 
	super setUp.
	importer := self importer. 

]

{ #category : #'tests - conversion' }
CCollectorDLittleImporter2Test >> testConversionOfProperties [
	
	| book dl |
	dl := self parse: '(price : 2.39) (read : no) (style : SF))'.
	self flag: #toRevisitOnceConfigIsManaged.
	"so far do not test anything new"
	book := CBookItem newWith: 'Les vents du changement'.
	importer importLeaf: dl head for: book.					
	self assert: book price equals: 2.39.


]

{ #category : #'tests - import configuration' }
CCollectorDLittleImporter2Test >> testImportConfigure [
	| config dl |
	self flag: #Todo. 
	"ShoudIntegrateIlyasChangeForOptionalValue".
	dl := self parse: 
	'(config: config 
		(types : types
	   		(price : number)
			(read : boolean)
			(complete : boolean)
			(style : string)))'.
			
	config := CImporterConfiguration new.
	importer importList: dl rest into: config.
	importer configureUsing: config.
	self assert: (importer convertSelectorFor: #price) equals: #convertNumber.
	self assert: (importer convertSelectorFor: #read) equals: #convertBoolean.
]

{ #category : #'tests - importing basic' }
CCollectorDLittleImporter2Test >> testImportEntity [
	| book dl |
	dl := self parse: '(title : Les vents du changement (read : no) (style : SF) (price : 2.39))'.
	book := importer import: dl.
					
	self assert: book title equals: 'Les vents du changement'.
	self assert: book price equals: 2.39.
	self assert: book style equals: 'SF'.
	self deny: book read

]

{ #category : #'tests - inmporting nested' }
CCollectorDLittleImporter2Test >> testImportEntityWithNestedEntityAndKnownProperties [
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

{ #category : #'tests - inmporting nested' }
CCollectorDLittleImporter2Test >> testImportEntityWithNestedEntityAndProperties [
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

{ #category : #'tests - inmporting nested' }
CCollectorDLittleImporter2Test >> testImportEntityWithNestedEntityAndUnknownProperties [
	| serie dl |
	dl := (self
				parse:
					'(series : la cour
						(title : la cours du chaos (read : no) (style : SF) (price : 2.39) (zorkzork : 1.3))
						(title : Les 9 princes d''ambre (read : no) (style : SF) (price : 2.3) )
						(ZORKZORK : true)
						)').
	serie := importer import: dl.

	"a Series got created. "
	self assert: serie name equals: 'la cour'.

	"the entities composing it got created too."
	self assert: serie items size equals: 2.
	self assert: (serie propertyAt: #ZORKZORK) equals: 'true'
]

{ #category : #'tests - importing basic' }
CCollectorDLittleImporter2Test >> testImportKnownProperty [
	
	| book dl |
	dl := self parse: '(price : 2.39) (read : no) (style : SF))'.
	book := CBookItem newWith: 'Les vents du changement'.
	importer importLeaf: dl head for: book.					
	self assert: book price equals: 2.39.


]

{ #category : #'tests - inmporting nested' }
CCollectorDLittleImporter2Test >> testImportNestedEntity [
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

{ #category : #'tests - importing basic' }
CCollectorDLittleImporter2Test >> testImportProperties [
	
	| book dl |
	dl := self parse: '(empty : empty 
								(zork : 2.39) (read : no) (style : SF))'.
	book := CBookItem newWith: 'Les vents du changement'.
	importer importProperties: dl rest for: book.					
	self assert: (book propertyAt: #zork)  equals: '2.39'.
	self deny: book read.
	self assert: book style equals: 'SF'

]

{ #category : #'tests - importing basic' }
CCollectorDLittleImporter2Test >> testImportUnknownProperty [
	
	| book dl |
	dl := self parse: '(zork : 2.39) (read : no) (style : SF))'.
	book := CBookItem newWith: 'Les vents du changement'.
	importer importLeaf: dl head for: book.					
	self assert: (book propertyAt: #zork)  equals: '2.39'.


]
