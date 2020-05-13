"
An importer for the game collector.
So far not fully tested.
"
Class {
	#name : #CGmCollectorDLittleImporter,
	#superclass : #Object,
	#instVars : [
		'mapper',
		'col'
	],
	#category : #'Collector-Game-DLittleImporter'
}

{ #category : #'instance creation' }
CGmCollectorDLittleImporter class >> importFromFileName: aName [
	"self importFromFileName: '/Users/ducasse/Workspace/FirstCircle/Working/SF/sf/books.yml'  "
	^ self new import: aName asFileReference readStream contents; yourself
]

{ #category : #'meta testing' }
CGmCollectorDLittleImporter >> checkMethodExist: aSelector [ 
	^ self class canUnderstand: aSelector
]

{ #category : #importing }
CGmCollectorDLittleImporter >> convertTitle: list [
	"list = (a:b (c:d) (e:f))"
	
 	col add: (self gameFrom: list)
]

{ #category : #importing }
CGmCollectorDLittleImporter >> convertTopLevelItems: list [
  "Here list = (
						(a:b (c:d) (e:f))
						(A:B (C:D) (E:F))
					), 
	we perform convertA:, converta: when methods are available,
	else raises an error"
	"we can do something more static one we will have a metamodel"
		
	list restDo: [:b | | sel | 
		sel := (#convert, b key capitalized , ':') asSymbol. 
		(self checkMethodExist: sel) 
				ifTrue: [self perform: sel with: b ]]
]

{ #category : #initialization }
CGmCollectorDLittleImporter >> defaultMapper [

	| map |
	map := CMapper new.
	map convert: 'price' using: [ :each | each asNumber ].
	map convert: 'year' using: [ :each | each asNumber ].
	map convert: 'read' using: [ :each | each asLowercase = 'no' ifTrue: [ false ] ifFalse: [ true ] ].
	^ map

		
]

{ #category : #extracting }
CGmCollectorDLittleImporter >> gameFrom: aList [
	
	| book |
	book := CGameItem new.
	aList keysAndValuesDo: [ :k :v | 
		book 
			perform: (mapper selectorFor: k) asMutator
			with: (mapper convert: k value: v) ].
	^ book
]

{ #category : #importing }
CGmCollectorDLittleImporter >> import: aString [

	| list sum |
	list := DLittleLParser parse: aString.
	sum := list last.
	col name: list value.
	list removeFromRest: sum.
	self convertTopLevelItems: list.
	self validateSumIsCorrect: sum value
]

{ #category : #importing }
CGmCollectorDLittleImporter >> importFromFileName: afileName [

	| fileRef |
	fileRef := afileName asFileReference. 
	self import: fileRef readStream contents. 
]

{ #category : #accessing }
CGmCollectorDLittleImporter >> importedCollection [

	^ col 
]

{ #category : #accessing }
CGmCollectorDLittleImporter >> importedItemSize [

	^ col size
]

{ #category : #initialization }
CGmCollectorDLittleImporter >> initialize [

	super initialize.
	col := CCollection new.
	mapper := self defaultMapper
]

{ #category : #initialization }
CGmCollectorDLittleImporter >> mapper: aMapper [

	mapper := aMapper
]

{ #category : #importing }
CGmCollectorDLittleImporter >> validateSumIsCorrect: sum [

	^ col size = sum asNumber
		ifFalse: [ CImporterError new messageText: 'Expecting ', sum asString, ' but imported ', col size asString ; signal]
]
