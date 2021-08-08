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
		'types',
		'aliases',
		'domains'
	],
	#category : #'Collector-Book-DLittleImporter2'
}

{ #category : #adding }
CImporterConfiguration >> add: anElement [
	"todo change this after removing the type and alias attributes from the classes CAlias/CType"

	(anElement class canUnderstand: #type)
		ifTrue: [ ^types add: anElement ].
	(anElement class canUnderstand: #alias)
		ifTrue: [ ^aliases add: anElement. ].
	(anElement class canUnderstand: #domain)
		ifTrue: [ ^domains add: anElement ].
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
	So I had to refy types this way.
	 
		( configuration :
			(types: 
				(price : number)
				(read : boolean)
				))
	"

	types isNotEmpty ifTrue: [ 
		types first propertiesKeysAndValuesDo: [ :k :v | 
			anImporter
				declareConversionSelector: 'convertTo' , v capitalized , ':'
				for: k asSymbol ] ].

	domains isNotEmpty ifTrue: [ 
		self createClasses.
		domains first propertiesKeysAndValuesDo: [ :k :v | 
			anImporter
				addMapping: (self class environment at: v asSymbol)
				for: k asSymbol ] ].
		
	aliases isNotEmpty ifTrue: [ 
		aliases first propertiesKeysAndValuesDo: [ :k :v | 
			anImporter declareAlias: k asSymbol for: v asSymbol ] ]
]

{ #category : #initialization }
CImporterConfiguration >> createClasses [
	domains first propertiesKeysAndValuesDo: [ :k :v |
		FluidClassBuilder new
		superclassToBuild: CObject;
		classNameToBuild: v asSymbol;
		package: 'Collector-Book-DLittleImporter2';
		install.
	].
]

{ #category : #accessing }
CImporterConfiguration >> domains [
	
	^domains
]

{ #category : #initialization }
CImporterConfiguration >> initialize [ 
	super initialize.
	types := OrderedCollection new.
	aliases := OrderedCollection new.
	domains := OrderedCollection new
]

{ #category : #accessing }
CImporterConfiguration >> types [
	
	^types
]
