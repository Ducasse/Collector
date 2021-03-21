"
For the moment I'm not connected in the importer2

The tests are using me as follows: 

```

	| dl config importer |
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
```
"
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
	So I had to refy types this way.
	 
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
