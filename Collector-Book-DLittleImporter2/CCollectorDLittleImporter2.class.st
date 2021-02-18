"
(CCollectorDLittleImporter2 new importFromFileName: '/Users/ducasse/Workspace/FirstCircle/Working/SF/sf/books.dl')
"
Class {
	#name : #CCollectorDLittleImporter2,
	#superclass : #Object,
	#instVars : [
		'current',
		'mapping',
		'aliases',
		'elementaryConverter',
		'converterMapping'
	],
	#category : #'Collector-Book-DLittleImporter2'
}

{ #category : #query }
CCollectorDLittleImporter2 >> addMapping: aClass for: aSymbol [ 
	mapping 
		at: aSymbol put: aClass.
]

{ #category : #accessing }
CCollectorDLittleImporter2 >> aliases [
	^aliases
]

{ #category : #configuration }
CCollectorDLittleImporter2 >> configureUsing: aConfiguration [

	aConfiguration configureImporter: self
]

{ #category : #'importing - private' }
CCollectorDLittleImporter2 >> convert: aPair for: anItem [
	
	^ anItem shouldConvert 
		ifTrue: [ self perform: (self convertSelectorFor: aPair key asSymbol) with: aPair value  ]
		ifFalse: [  aPair value ]
]

{ #category : #'conversion logic' }
CCollectorDLittleImporter2 >> convertSelectorFor: aSymbol [
	(converterMapping includesKey: aSymbol)
		ifTrue: [ ^converterMapping at: aSymbol asSymbol ]
		ifFalse: [ 
			^(aliases includesKey: aSymbol asSymbol) 
				ifTrue: [ self convertSelectorFor: (aliases at: aSymbol asSymbol) ]
				ifFalse: [ #convertToTheSame: ] ].
]

{ #category : #'conversion logic' }
CCollectorDLittleImporter2 >> convertToBoolean: aString [
	aString asLowercase = 'true' 
		ifTrue: [ ^true ].
		
	aliases at: aString
		ifPresent: [ :value | ^value = #true ].
		
	^false
]

{ #category : #'conversion logic' }
CCollectorDLittleImporter2 >> convertToNumber: aString [

	^ aString asNumber
]

{ #category : #'conversion logic' }
CCollectorDLittleImporter2 >> convertToString: aString [

	^ aString
]

{ #category : #'conversion logic' }
CCollectorDLittleImporter2 >> convertToTheSame: aString [

	^ aString
]

{ #category : #'importing - private' }
CCollectorDLittleImporter2 >> createEntity: aPair [
	"Return the entity object corresponding to aPair"
	"Precondition: aPair key identifies an entity and not a property."
	
	^ (self mappingFor: aPair key) newWith: aPair value
]

{ #category : #'conversion logic' }
CCollectorDLittleImporter2 >> declareAlias: anAlias for: anAttribute [
	
	aliases
		at: anAlias 
		put: anAttribute asSymbol
]

{ #category : #'conversion logic' }
CCollectorDLittleImporter2 >> declareConversionSelector: aSelector for: anAttributeName [
	
	converterMapping 
		at: anAttributeName asSymbol 
		put: aSelector asSymbol
]

{ #category : #mapper }
CCollectorDLittleImporter2 >> defaultMapper [

	| map |
	map := CMapper new.
	map convert: #price using: [ :each | each asNumber ].
	map convert: #year using: [ :each | each asNumber ].
	map convert: #read using: [ :each | each asLowercase = 'no' ifTrue: [ false ] ifFalse: [ true ] ].
	map convert: #complete using: [ :each | each asLowercase = 'no' ifTrue: [ false ] ifFalse: [ true ] ].
	map convert: #finished using: [ :each | each asLowercase = 'no' ifTrue: [ false ] ifFalse: [ true ] ].
	map convert: #numberOfBooks using: [:each | each asNumber ].
	^ map

]

{ #category : #testing }
CCollectorDLittleImporter2 >> hasMappingFor: aSymbol [
	^ mapping keys includes: aSymbol asSymbol
]

{ #category : #'importing public API' }
CCollectorDLittleImporter2 >> import: aDL [
	"Toplevel import: creates an entity from aDL that is of the form: key value list key-val"
	
	^ self importList: aDL rest into: (self createEntity: aDL head) 
	
]

{ #category : #'importing - private' }
CCollectorDLittleImporter2 >> importDL: aDL into: anElement [ 
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

{ #category : #files }
CCollectorDLittleImporter2 >> importFromFileName: afileName [

	| fileRef |
	fileRef := afileName asFileReference. 
	^ self importFromString: fileRef readStream contents. 
]

{ #category : #'importing public API' }
CCollectorDLittleImporter2 >> importFromString: aString [
	"Toplevel import: creates an entity from aDL that is of the form: key value list key-val"
	
	| aDL |
	aDL := DLittleLParser parse: aString.
	^ self importList: aDL rest into: (self createEntity: aDL head) 
	
]

{ #category : #'importing - private' }
CCollectorDLittleImporter2 >> importLeaf: aDL for: anItem [	
	"Given a property expressed as a pair key val modifies an item to hold this property."
	| key |
	key := aDL key asSymbol.
	"We try to set an alias attribute if the given one isn't understood"
	(anItem class canUnderstand: key)
		ifFalse: [ 
			(aliases includesKey: key) 
				ifTrue: [ key := (aliases at: key) ]].

	(anItem class canUnderstand: key)
		ifTrue: [ anItem perform: key asMutator with: (self convert: aDL for: anItem) ] 
		ifFalse: [ anItem propertyAt: aDL key put: (self convert: aDL for: anItem)]
		
]

{ #category : #'importing - private' }
CCollectorDLittleImporter2 >> importList: aDLCol into: anElement [ 
	"aDL is of a collection of dl elements where key val pair can either be a property or an entity"

	aDLCol do: [ :aDL |
		self importDL: aDL into: anElement ].
		
	^ anElement
]

{ #category : #'importing - private' }
CCollectorDLittleImporter2 >> importProperties: aCollection for: anItem [
	"aDL is a list of key value. Import them as properties of anItem."

	aCollection do: [ :aPair |
			self 
				importLeaf: aPair 
				for: anItem ].	

 
]

{ #category : #initialization }
CCollectorDLittleImporter2 >> initialize [ 
	super initialize.
	current := OrderedCollection new. 
	elementaryConverter := self defaultMapper.
	converterMapping := Dictionary new. 
	aliases := Dictionary new.
	mapping := Dictionary new.
	mapping 
		at: #title put: CBookItem;
		at: #series put: CSerieItem;
		at: #author put: CBookAuthor;
		at: #collection put: CCollection;		
		at: #types put: CType;
		at: #aliases put: CAlias;
		at: #domains put: CDomain
		
]

{ #category : #query }
CCollectorDLittleImporter2 >> mappingFor: aSymbol [ 
	^ mapping at: aSymbol ifAbsent: [ nil ]
]
