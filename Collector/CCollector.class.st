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
	#name : #CCollector,
	#superclass : #Object,
	#instVars : [
		'fileName',
		'collectionDictionary'
	],
	#category : #'Collector-Core'
}

{ #category : #import }
CCollector class >> filename [
	^ 'Games'
]

{ #category : #import }
CCollector class >> loadFromFileReference: aFileReference [
	"self loadFromFileReference: (FileSystem workingDirectory / 'Games.1.ston') "
	^ STON fromStream: aFileReference readStream
]

{ #category : #import }
CCollector class >> loadFromStream: aStream [
	^ STON fromStream: aStream
]

{ #category : #import }
CCollector class >> loadLatestSTON [
	| fs |
	fs := FileSystem workingDirectory.
	^ self
		loadFromFileReference: (fs lastFileFor: self filename extension: 'ston')
]

{ #category : #'adding/removing' }
CCollector >> add: aGameItem to: aCollectionSymbol [
	(collectionDictionary at: aCollectionSymbol) add: aGameItem .
]

{ #category : #conversion }
CCollector >> asSTON [
	^ String streamContents: [ :s | self asSTON: s ]
]

{ #category : #conversion }
CCollector >> asSTON: aStream [
	^  STON put: self onStreamPretty: aStream
]

{ #category : #'collection management' }
CCollector >> collectionNamed: aCollectionSymbol [ 
	^ collectionDictionary at: aCollectionSymbol
]

{ #category : #'collection management' }
CCollector >> declareNewCollection: aSymbol [
	(collectionDictionary includesKey: aSymbol)
		ifFalse: [ collectionDictionary at: aSymbol put: (CCollection new name: aSymbol) ]
]

{ #category : #'collection management' }
CCollector >> declaredCollectionNames [
	^ collectionDictionary keys
]

{ #category : #accessing }
CCollector >> fileName [
	^ fileName
]

{ #category : #accessing }
CCollector >> fileName: aString [ 
	fileName := aString
]

{ #category : #selection }
CCollector >> findInText: aPattern [
	^ self select: [ :each | (aPattern match: each title) or: [ aPattern match: each comments ] ]
]

{ #category : #initialize }
CCollector >> initialize [
	super initialize.
	fileName := self class filename.
	collectionDictionary := Dictionary new
]

{ #category : #'adding/removing' }
CCollector >> remove: aGameItem from: aSymbol [
	(self declaredCollectionNames includes: aSymbol)
		ifFalse: [^self].
	(self collectionNamed: aSymbol) remove: aGameItem 
		ifAbsent: [  ]
]

{ #category : #'file saving' }
CCollector >> save [
	| stream fs |
	fs := FileSystem workingDirectory.
	stream := (fs / (fs nextNameFor: self fileName extension: 'ston')) asFileReference writeStream.
	self asSTON: stream
]

{ #category : #selection }
CCollector >> select: aBlock [
	| result |
	result := OrderedCollection new.
	self declaredCollectionNames do: [ :aCollectionName | result addAll: ((self collectionNamed: aCollectionName) select: aBlock) ].
	^ result
]

{ #category : #accessing }
CCollector >> sizeOf: aSymbol [
	^ (self collectionNamed: aSymbol) size
]
