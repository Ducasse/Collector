Class {
	#name : #CImporterConfiguration,
	#superclass : #CObject,
	#instVars : [
		'types'
	],
	#category : #'Collector-Book-DLittleImporter2'
}

{ #category : #adding }
CImporterConfiguration >> add: anElement [

	types add: anElement
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
		]
]

{ #category : #initialization }
CImporterConfiguration >> initialize [ 
	super initialize.
	types := OrderedCollection new
]
