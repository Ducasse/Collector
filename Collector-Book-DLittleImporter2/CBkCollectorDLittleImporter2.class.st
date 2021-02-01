Class {
	#name : #CBkCollectorDLittleImporter2,
	#superclass : #Object,
	#instVars : [
		'current',
		'mapping'
	],
	#category : #'Collector-Book-DLittleImporter2'
}

{ #category : #extracting }
CBkCollectorDLittleImporter2 >> bookFrom: aDL [
	| newItem | 
	
	(self hasMappingFor: aDL key) 
		ifTrue: [ newItem := ((self mappingFor: aDL key) newWith: aDL value).
					current addFirst: newItem ]
		ifFalse: [ "we should handle properties" ].	
	aDL restDo: [ :pair | 
		"we are in the property and not in a mappable part"
	
		(newItem class canUnderstand: pair key asSymbol)
			 ifTrue: [ newItem perform: pair key asSymbol asMutator with: pair value ] 
			 ifFalse: [ newItem propertyAt: pair key asSymbol put: pair value  ]
		 ].	
	^ current first 
]

{ #category : #testing }
CBkCollectorDLittleImporter2 >> hasMappingFor: aString [ 
	^ mapping keys includes: aString
]

{ #category : #initialization }
CBkCollectorDLittleImporter2 >> initialize [ 
	super initialize.
	current := OrderedCollection new. 
	mapping := Dictionary new.
	mapping 
		at: #title put: CBookItem;
		at: #series put: CSerieItem
		
		
]

{ #category : #query }
CBkCollectorDLittleImporter2 >> mappingFor: aString [ 
	^ mapping at: aString ifAbsent: [ nil ]
]
