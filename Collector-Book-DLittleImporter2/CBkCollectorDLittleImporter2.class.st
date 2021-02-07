Class {
	#name : #CBkCollectorDLittleImporter2,
	#superclass : #Object,
	#instVars : [
		'current',
		'mapping',
		'elementaryConverter'
	],
	#category : #'Collector-Book-DLittleImporter2'
}

{ #category : #'importing - private' }
CBkCollectorDLittleImporter2 >> convert: aPair [

	^ elementaryConverter convert: aPair key value: aPair value
]

{ #category : #'importing - private' }
CBkCollectorDLittleImporter2 >> createEntity: aPair [
	"Return the entity object corresponding to aPair"
	"Precondition: aPair key identifies an entity and not a property."
	
	^ (self mappingFor: aPair key) newWith: aPair value
]

{ #category : #mapper }
CBkCollectorDLittleImporter2 >> defaultMapper [

	| map |
	map := CMapper new.
	map convert: #price using: [ :each | each asNumber ].
	map convert: #year using: [ :each | each asNumber ].
	map convert: #read using: [ :each | each asLowercase = 'no' ifTrue: [ false ] ifFalse: [ true ] ].
	^ map

]

{ #category : #testing }
CBkCollectorDLittleImporter2 >> hasMappingFor: aSymbol [
	^ mapping keys includes: aSymbol asSymbol
]

{ #category : #'importing public API' }
CBkCollectorDLittleImporter2 >> import: aDL [
	"Toplevel import: creates an entity from aDL that is of the form: key value list key-val"
	
	^ self importList: aDL rest into: (self createEntity: aDL head) 
	
]

{ #category : #'importing - private' }
CBkCollectorDLittleImporter2 >> importDL: aDL into: anElement [ 
	"aDL is key val List of DL where key val pair can either be a property or an entity.
	aDL 
		key val (aDL*)
	|  key val	
	"

	(self hasMappingFor: aDL key)
		ifTrue: [ 
			| newEntity| 
			newEntity := self createEntity: aDL.
			anElement add: newEntity.
			self importProperties: aDL rest for: newEntity ]
		ifFalse: [ 
			"we have a pair that is not a mapping hence 
			not creating a new object but probably property of an object" 
			self importLeaf: aDL for: anElement ].
]

{ #category : #'importing - private' }
CBkCollectorDLittleImporter2 >> importLeaf: aDL for: anItem [	
	"Given a property expressed as a pair key val modifies an item to hold this property."

	(anItem class canUnderstand: aDL key asSymbol)
		ifTrue: [ anItem perform: aDL key asSymbol asMutator with: (self convert: aDL) ] 
		ifFalse: [ anItem propertyAt: aDL key asSymbol put: (self convert: aDL)]
		
]

{ #category : #'importing - private' }
CBkCollectorDLittleImporter2 >> importList: aDLCol into: anElement [ 
	"aDL is of a collection of dl elements where key val pair can either be a property or an entity"

	aDLCol do: [ :aDL |
		self importDL: aDL into: anElement ].
		
	^ anElement
]

{ #category : #'importing - private' }
CBkCollectorDLittleImporter2 >> importProperties: aCollection for: anItem [
	"aDL is a list of key value. Import them as properties of anItem."

	aCollection do: [ :aPair |
			self 
				importLeaf: aPair 
				for: anItem ].	

 
]

{ #category : #initialization }
CBkCollectorDLittleImporter2 >> initialize [ 
	super initialize.
	current := OrderedCollection new. 
	elementaryConverter := self defaultMapper.
	mapping := Dictionary new.
	mapping 
		at: #title put: CBookItem;
		at: #series put: CSerieItem
		
		
]

{ #category : #query }
CBkCollectorDLittleImporter2 >> mappingFor: aSymbol [ 
	^ mapping at: aSymbol ifAbsent: [ nil ]
]
