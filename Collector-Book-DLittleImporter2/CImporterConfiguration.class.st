Class {
	#name : #CImporterConfiguration,
	#superclass : #CObject,
	#instVars : [
		'types',
		'aliases'
	],
	#category : #'Collector-Book-DLittleImporter2'
}

{ #category : #adding }
CImporterConfiguration >> add: anElement [
	"todo change this after removing the type and alias attributes from the classes CAlias/CType"
	
	(anElement class canUnderstand: #type asMutator)
		ifTrue: [ ^types add: anElement ].
	(anElement class canUnderstand: #alias asMutator )
		ifTrue: [ ^aliases add: anElement ].
	^self error.
]

{ #category : #accessing }
CImporterConfiguration >> aliases [
	
	^aliases
]

{ #category : #initialization }
CImporterConfiguration >> configureImporter: anImporter [
	
	"This is ugly because 
	when we have 
		( s 1 
			(attr 2)
			(attr 3)
	and s is not mapped to a domain entity we do not have a property dict for the entity. 
	So I had to refied types 
		( configuration :
			(types: 
				(price : number)
				(read : boolean)
				))
	"
	types first propertiesKeysAndValuesDo: [ :k :v |
			anImporter 
				declareConversionSelector: ('convertTo', v capitalized, ':') 
				for: k asSymbol
		].
	
	aliases first propertiesKeysAndValuesDo: [ :k :v |
			anImporter 
				declareAlias: k asSymbol
				for: v asSymbol
		]
]

{ #category : #initialization }
CImporterConfiguration >> initialize [ 
	super initialize.
	types := OrderedCollection new.
	aliases := OrderedCollection new
]

{ #category : #accessing }
CImporterConfiguration >> types [
	
	^types
]
