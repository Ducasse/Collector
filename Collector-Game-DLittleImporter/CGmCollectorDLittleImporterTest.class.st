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
	self assert: game name equals: 'Aragami'.
	self assert: game price equals: 15.
	
]

{ #category : #tests }
CGmCollectorDLittleImporterTest >> testExtractSerie [

	| import author |
	import := CBkCollectorDLittleImporter new.
	author := import extractAuthorFromString:  ' John'.
	import extractSerieFrom: (DLittleLParser parse: '(serie : Guide du routard galactique  
  	 		(title: Le guide du voyageur inter-galactique (read: true) (summary: un gars est capture par un vaisseau spatial et il lui arrive plein d''histoires aussi debiles les unes que les autres) (style: comic english humour))
   			(title: H2G2 2 (read: no) (style: comic english humour) (price: 2)))')
			 	withAuthor: author. 
	self assert: import importedItemSize equals: 2.
	self assert: import importedCollection items first serie name equals: 'Guide du routard galactique'
	

]

{ #category : #tests }
CGmCollectorDLittleImporterTest >> testImport [

	| ce liconia |
	ce := CBkCollectorDLittleImporter new import: self class minilist.
	self assert: ce importedItemSize equals: 8.
	liconia := ce importedCollection items select: [ :each |  '*liconia*' match: each title  ].
	self assert: liconia size equals: 3.
	liconia do: [ :each | self assert: ('*liconia*' match: each serie name) ]
]

{ #category : #tests }
CGmCollectorDLittleImporterTest >> testImport2 [

	| ce book1 |
	self skip.
	ce := CBkCollectorDLittleImporter new import: self class minilist.
	self assert: ce importedItemSize equals: 8.
	book1 := (ce importedCollection items select: [ :each | each title = 'Le printemps d''helliconia' ]) first.
	self assert: book1 title equals: 'Le printemps d''helliconia'.
	"with some other situations I lost the title"
	self assert: book1 authors size equals: 1.
]

{ #category : #tests }
CGmCollectorDLittleImporterTest >> testParseMinilist [

	self shouldnt: [ DLittleLParser parse: self class minilist] raise: Error
]
