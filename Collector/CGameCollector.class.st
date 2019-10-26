"
GameCollector loadLatestSTON


Todo: 
- gestion des collections. 
       - [Done] the user may want to add a new collection like (#shittyTitles).
       - move all items from collection to another. 
	  - Remove collection without losing the items. may be put them in a limbo collection 
	 




GameCollector {
	#fileName : 'Games',
	#collectionDictionary : {
		#looking : OrderedCollection [
			GameItem {
				#console : #PS2,
				#hasDocumentation : true,
				#hasBox : true,
				#finished : false,
				#condition : 'Good',
				#quotation : 10,
				#critics : 15,
				#comments : '',
				#title : 'Asterix XXL'
			}
		],
		#owned : OrderedCollection [
			GameItem {
				#console : #PS2,
				#hasDocumentation : false,
				#hasBox : true,
				#finished : false,
				#condition : 'Good',
				#quotation : 5,
				#critics : 17,
				#comments : '',
				#title : 'Adibou et les voleurs d\'énergie'
			},
			GameItem {
				#console : #PS2,
				#hasDocumentation : false,
				#hasBox : true,
				#finished : false,
				#condition : 'Good',
				#quotation : 5,
				#critics : 17,
				#comments : '',
				#title : 'Ace Combat: Squadron Leader'
			},
			GameItem {
				#console : #PS2,
				#hasDocumentation : false,
				#hasBox : true,
				#finished : true,
				#condition : 'Good',
				#quotation : 15,
				#critics : 15,
				#comments : '',
				#title : 'Asterix XXL/2: mission last vegum'
			}
		]
	}
}
"
Class {
	#name : #CGameCollector,
	#superclass : #Object,
	#instVars : [
		'fileName',
		'collectionDictionary'
	],
	#category : #'Collector-Core'
}

{ #category : #import }
CGameCollector class >> loadFromFileReference: aFileReference [
	"self loadFromFileReference: (FileSystem workingDirectory / 'Games.1.ston') "
	^ STON fromStream: aFileReference readStream
]

{ #category : #import }
CGameCollector class >> loadFromStream: aStream [
	^ STON fromStream: aStream
]

{ #category : #import }
CGameCollector class >> loadLatestSTON [

	| fs |
	fs := FileSystem workingDirectory.
	^ self loadFromFileReference: (fs lastFileFor: 'Games' extension: 'ston').


]

{ #category : #examples }
CGameCollector class >> smallCollection [
	<sampleInstance>
	| collector item1 item2 |
	collector := self new.
	collector declareNewCollection: #owned.
	item1 := CGameItem finalFantasyX.
	collector add: item1 to: #owned.
	item2 := CGameItem new
		title: 'Final Fantasy XII';
		hasBox: false;
		quotation: 10;
		critics: 15.
	collector add: item2 to: #owned.
	^ collector
]

{ #category : #examples }
CGameCollector class >> smallCollection2 [
	<sampleInstance>
	| collector item1 item2 item3 |
	collector := self new.
	collector declareNewCollection: #owned.
	item1 := CGameItem finalFantasyX.
	collector add: item1 to: #owned.
	item2 := CGameItem new
		title: 'Dragon Quest VIII: Journey Of The Cursed King';
		hasBox: true;
		quotation: 10;
		critics: 18;
		setPS2.
	collector add: item2 to: #owned.
	item3 := CGameItem new
		title: 'Persona 3';
		hasBox: true;
		quotation: 20;
		critics: 18;
		setPS3.
	collector add: item3 to: #owned.
	^ collector
]

{ #category : #'adding/removing' }
CGameCollector >> add: aGameItem to: aCollectionSymbol [
	(collectionDictionary at: aCollectionSymbol) add: aGameItem .
]

{ #category : #conversion }
CGameCollector >> asSTON [
	^ String streamContents: [ :s | self asSTON: s ]
]

{ #category : #conversion }
CGameCollector >> asSTON: aStream [
	^  STON put: self onStreamPretty: aStream
]

{ #category : #'collection management' }
CGameCollector >> collectionNamed: aCollectionSymbol [ 
	^ collectionDictionary at: aCollectionSymbol
]

{ #category : #'collection management' }
CGameCollector >> declareNewCollection: aSymbol [
	(collectionDictionary includesKey: aSymbol)
	ifFalse: 
	[ collectionDictionary at: aSymbol put: OrderedCollection new ]
]

{ #category : #'collection management' }
CGameCollector >> declaredCollectionNames [
	^ collectionDictionary keys.
]

{ #category : #accessing }
CGameCollector >> fileName [
	^ fileName
]

{ #category : #accessing }
CGameCollector >> fileName: aString [ 
	fileName := aString
]

{ #category : #selection }
CGameCollector >> findInText: aPattern [
	^ self select: [ :each | (aPattern match: each title) or: [ aPattern match: each comments ] ]
]

{ #category : #initialize }
CGameCollector >> initialize [
	super initialize.
	fileName := 'Games'.
	collectionDictionary := Dictionary new
]

{ #category : #'adding/removing' }
CGameCollector >> remove: aGameItem from: aSymbol [
	(self declaredCollectionNames includes: aSymbol)
	ifFalse: [^self].
	(self collectionNamed: aSymbol) remove: aGameItem 
	ifAbsent: [  ]
]

{ #category : #'file saving' }
CGameCollector >> save [
	| stream fs |
	fs := FileSystem workingDirectory.
	stream := (fs / (fs nextNameFor: self fileName extension: 'ston')) asFileReference writeStream.
	self asSTON: stream
]

{ #category : #selection }
CGameCollector >> select: aBlock [
	| result |
	result := OrderedCollection new.
	self declaredCollectionNames do: [ :aCollectionName | result addAll: ((self collectionNamed: aCollectionName) select: aBlock) ].
	^ result
]

{ #category : #accessing }
CGameCollector >> sizeOf: aSymbol [
	^ (self collectionNamed: aSymbol) size
]
