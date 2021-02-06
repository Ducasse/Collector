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

{ #category : #extracting }
CBkCollectorDLittleImporter2 >> bookFrom: aDL [

	| newItem |
	(self hasMappingFor: aDL key)
		ifTrue: [ 
			newItem := self createEntity: aDL.
			current addFirst: newItem ]
		ifFalse: [ "we should handle properties" ].
	aDL restDo: [ :pair | "we are in the property and not in a mappable part""aList keysAndValuesDo: [ :k :v | 
		book 
			perform: (mapper selectorFor: k) asMutator
			with: (mapper convert: k value: v) ]."
		(newItem class canUnderstand: pair key asSymbol)
			ifTrue: [ 
				newItem
					perform: pair key asSymbol asMutator
					with: (self convert: pair) ]
			ifFalse: [ 
			newItem propertyAt: pair key asSymbol put: (self convert: pair) ] ].
	^ current first
]

{ #category : #extracting }
CBkCollectorDLittleImporter2 >> convert: aPair [

	^ elementaryConverter convert: aPair key value: aPair value
]

{ #category : #extracting }
CBkCollectorDLittleImporter2 >> createEntity: aPair [

	current addFirst: ((self mappingFor: aPair key) newWith: aPair value)
]

{ #category : #mapper }
CBkCollectorDLittleImporter2 >> defaultMapper [

	| map |
	map := CMapper new.
	map convert: 'price' using: [ :each | each asNumber ].
	map convert: 'year' using: [ :each | each asNumber ].
	map convert: 'read' using: [ :each | each asLowercase = 'no' ifTrue: [ false ] ifFalse: [ true ] ].
	^ map

]

{ #category : #testing }
CBkCollectorDLittleImporter2 >> hasMappingFor: aString [ 
	^ mapping keys includes: aString
]

{ #category : #extracting }
CBkCollectorDLittleImporter2 >> importFrom: aDL [
	"aDL is of the form: key value rest*"

	(self hasMappingFor: aDL key)
		ifTrue: [ 
			self createEntity: aDL.
			self importProperties: aDL rest for: current first]
		ifFalse: [ "we have a pair that is not a mapping hence 
			not creating a new object but probably property of an object" 
			self importPair: aDL for: current first ].
	^ current first
]

{ #category : #extracting }
CBkCollectorDLittleImporter2 >> importPair: aDL for: anItem [	
	"Given a property expressed as a pair key val modifies an item to hold this property."

	(anItem class canUnderstand: aDL key asSymbol)
		ifTrue: [ anItem perform: aDL key asSymbol asMutator with: (self convert: aDL) ] 
		ifFalse: [ anItem propertyAt: aDL key asSymbol put: (self convert: aDL)]
		
]

{ #category : #extracting }
CBkCollectorDLittleImporter2 >> importProperties: aCollection for: anItem [
	"aDL is a list of key value. Import them as properties of anItem."

	aCollection do: [ :aPair |
			self 
				importPair: aPair 
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
CBkCollectorDLittleImporter2 >> mappingFor: aString [ 
	^ mapping at: aString ifAbsent: [ nil ]
]
