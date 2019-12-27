Class {
	#name : #CGmCollectorDLittleImporterTest,
	#superclass : #TestCase,
	#category : #'Collector-Game-DLittleImporter'
}

{ #category : #resources }
CGmCollectorDLittleImporterTest class >> minilist [

	^ '(collection : OurPS4
	(title : Aragami (price : 15))
	(title : Arcania (price : 10))
	(title : Battle Chasers Nightwar (price : 20))
	(title : Bloodborne collector (price : 17))
	(sum : 4))
'
]

{ #category : #resources }
CGmCollectorDLittleImporterTest class >> oneGame [

	^ '(title : Aragami (price : 15))'
]

{ #category : #tests }
CGmCollectorDLittleImporterTest >> testExtractGame [

	| game |
	game := (CGmCollectorDLittleImporter new 
					gameFrom: (DLittleLParser parse: self class oneGame)).
	self assert: game title equals: 'Aragami'.
	self assert: game price equals: 15.
	
]

{ #category : #tests }
CGmCollectorDLittleImporterTest >> testImport [

	| ce |
	ce := CGmCollectorDLittleImporter new import: self class minilist.
	self assert: ce importedItemSize equals: 4.
	self assert: (ce importedCollection items select: [ :each | each title = 'Aragami' ]) first price equals: 15
	
]

{ #category : #tests }
CGmCollectorDLittleImporterTest >> testParseMinilist [

	self shouldnt: [ DLittleLParser parse: self class minilist] raise: Error
]
