Class {
	#name : #GameCollectorTest,
	#superclass : #TestCase,
	#instVars : [
		'collector'
	],
	#category : #'Collector-Tests'
}

{ #category : #tests }
GameCollectorTest >> setUp [
	
	collector := CGameCollector new.
	collector declareNewCollection: #owned.	
]

{ #category : #tests }
GameCollectorTest >> testAddThreeElements [
	| item1 item2 item3 |
	item1 := CGameItem new title: 'Final Fantasy X'.
	collector add: item1 to: #owned.
	item2 := CGameItem new title: 'Final Fantasy XII'.
	collector add: item2 to: #owned.
	item3 := CGameItem new title: 'Final Fantasy X-2'.
	collector add: item3 to: #owned.
	self assert: (collector collectionNamed: #owned )size equals: 3
]

{ #category : #tests }
GameCollectorTest >> testAddTwoCopies [
	| item1 item2 |
	item1 := CGameItem new title: 'Final Fantasy X'.
	collector add: item1 to: #owned.
	item2 := CGameItem new title: 'Final Fantasy X'.
	collector add: item2 to: #owned.
	self assert: (collector collectionNamed: #owned) size equals: 2
]

{ #category : #tests }
GameCollectorTest >> testConvertToSTON [
	| collec item1 item2 |
	collec := CGameCollector new.
	collec declareNewCollection: #owned.
	item1 := CGameItem finalFantasyX.
	collec add: item1 to: #owned.
	item2 := CGameItem new
		title: 'Final Fantasy XII';
		hasBox: false;
		quotation: 10;
		critics: 15.
	collec add: item2 to: #owned.
	self
		assert: collec asSTON
		equals:
			 'CGameCollector {
	#fileName : ''Games'',
	#collectionDictionary : {
		#owned : CCollection {
			#items : OrderedCollection [
				CGameItem {
					#console : #PS2,
					#hasDocumentation : false,
					#hasBox : true,
					#finished : true,
					#condition : ''Good'',
					#quotation : 10,
					#critics : 18,
					#comments : ''quite cool in fact'',
					#coverUrlPart : ''finalfantasyx_eu'',
					#title : ''Final Fantasy X''
				},
				CGameItem {
					#hasDocumentation : true,
					#hasBox : false,
					#finished : false,
					#condition : ''Good'',
					#quotation : 10,
					#critics : 15,
					#comments : '''',
					#title : ''Final Fantasy XII''
				}
			],
			#name : #owned
		}
	}
}'
]

{ #category : #tests }
GameCollectorTest >> testDeclareAlreadyNamedCollection [

	| gc1 |
	gc1 := CCollector new.
	gc1 declareNewCollection: #Collec1.
	gc1 add: CGameItem finalFantasyX to: #Collec1.
	gc1 declareNewCollection: #Collec1.
	self assert: (gc1 collectionNamed: #Collec1) size equals: 1
]

{ #category : #tests }
GameCollectorTest >> testDeclareNewCollection [
	| gc1 |
	gc1 := CCollector new.
	gc1 declareNewCollection: #Collec1.
	gc1 add: CGameItem finalFantasyX to: #Collec1.
	self assert: (gc1 collectionNamed: #Collec1) size equals: 1
]

{ #category : #tests }
GameCollectorTest >> testDeclaredCollectionNames [
	| gc1 |
	gc1 := CCollector new.
	gc1 declareNewCollection: #Collec1.
	gc1 add: CGameItem finalFantasyX to: #Collec1.
	self assert: (gc1 declaredCollectionNames includes: #Collec1).
	self assert: gc1 declaredCollectionNames size equals: 1.
	gc1 declareNewCollection: #Collec2.
	self assert: gc1 declaredCollectionNames size equals: 2.
	self assert: (gc1 declaredCollectionNames includes: #Collec2)
]

{ #category : #tests }
GameCollectorTest >> testFileName [
	CGameCollector smallCollection
		fileName: 'TestCollec';
		save.
	self assert: (FileSystem workingDirectory / 'TestCollec.1.ston') exists.
	(FileSystem workingDirectory / 'TestCollec.1.ston') delete.
]

{ #category : #tests }
GameCollectorTest >> testFindInText [
	| item1 item2 |
	item1 := CGameItem new
		title: 'Final Fantasy X';
		hasDocumentation: false;
		finished: true;
		quotation: 10;
		critics: 18;
		comments: 'Super cool'.
	collector add: item1 to: #owned.
	item2 := CGameItem new
		title: 'Gitaroo Man';
		hasBox: false;
		quotation: 25;
		critics: 15;
		comments: 'Finalement !'.
	collector add: item2 to: #owned.
	self
		assert: (collector findInText: '*Final*')
		equals:
			{item1.
			item2} asOrderedCollection.
	self
		assert: (collector findInText: '*cool*')
		equals: {item1} asOrderedCollection
]

{ #category : #tests }
GameCollectorTest >> testIsAnEmptyCollection [
	self assert: (collector collectionNamed: #owned) size equals: 0
]

{ #category : #tests }
GameCollectorTest >> testRemoveExisting [
	| item1 item2 item3 |
	item1 := CGameItem new title: 'Final Fantasy X'.
	collector add: item1 to: #owned.
	item2 := CGameItem new title: 'Final Fantasy XII'.
	collector add: item2 to: #owned.
	item3 := CGameItem new title: 'Final Fantasy X-2'.
	collector add: item3 to: #owned.
	self assert: (collector collectionNamed: #owned) size equals: 3.
	(collector collectionNamed: #owned) remove: item1.
	self assert: (collector collectionNamed: #owned) size equals: 2.
	self deny: ((collector collectionNamed: #owned) includes: item1)
]

{ #category : #tests }
GameCollectorTest >> testRemoveFrom [
	| item |
	collector := CGameCollector smallCollection.
	item := (collector collectionNamed: #owned) anyOne.
	collector remove: item from: #owned.
	self assert: (collector collectionNamed: #owned) size equals: 1
]

{ #category : #tests }
GameCollectorTest >> testRemoveNonExisting [
	| item1 item2 item3 |
	item1 := CGameItem new title: 'Final Fantasy X'.
	item2 := CGameItem new title: 'Final Fantasy XII'.
	collector add: item2 to: #owned.
	item3 := CGameItem new title: 'Final Fantasy X-2'.
	collector add: item3 to: #owned.
	self assert: (collector collectionNamed: #owned) size equals: 2.
	collector remove: item1 from: #owned.
	self assert: (collector collectionNamed: #owned) size equals: 2.
	self deny: ((collector collectionNamed: #owned) includes: item1)
]

{ #category : #tests }
GameCollectorTest >> testSelectMultipleCollections [
	| item1 item2 item3 |
	item1 := CGameItem new
		title: 'Final Fantasy X';
		hasDocumentation: false;
		finished: true;
		quotation: 10;
		critics: 18.
	collector add: item1 to: #owned.
	item2 := CGameItem new
		title: 'Final Fantasy XII';
		hasBox: false;
		quotation: 10;
		critics: 15.
	collector add: item2 to: #owned.
	collector declareNewCollection: #owned2.
	item3 := CGameItem new
		title: 'Final Fantasy XIII';
		hasDocumentation: true.
	collector add: item3 to: #owned2.
	self
		assert: (collector select: [ :each | each hasDocumentation ]) asSet
		equals:
			{item2.
			item3} asSet
]

{ #category : #tests }
GameCollectorTest >> testSelectMultipleResults [
	| item1 item2 |
	item1 := CGameItem new
		title: 'Final Fantasy X';
		hasDocumentation: false;
		finished: true;
		quotation: 10;
		critics: 18.
	collector add: item1 to: #owned.
	item2 := CGameItem new
		title: 'Final Fantasy XII';
		hasBox: false;
		quotation: 10;
		critics: 15.
	collector add: item2 to: #owned.
	self
		assert: (collector select: [ :each | '*Final*' match: each title ])
		equals:
			{item1.
			item2} asOrderedCollection
]

{ #category : #tests }
GameCollectorTest >> testSelectNoResults [
	| item1 item2 |
	item1 := CGameItem new
		title: 'Final Fantasy X';
		hasDocumentation: false;
		finished: true;
		quotation: 10;
		critics: 18.
	collector add: item1 to: #owned.
	item2 := CGameItem new
		title: 'Final Fantasy XII';
		hasBox: false;
		quotation: 10;
		critics: 15.
	collector add: item2 to: #owned.
	self
		assert: (collector select: [ :each | each quotation = 8 ])
		equals: {} asOrderedCollection
]

{ #category : #tests }
GameCollectorTest >> testSelectOneCollection [
	| item1 item2 |
	item1 := CGameItem new
		title: 'Final Fantasy X';
		hasDocumentation: false;
		finished: true;
		quotation: 10;
		critics: 18.
	collector add: item1 to: #owned.
	item2 := CGameItem new
		title: 'Final Fantasy XII';
		hasBox: false;
		quotation: 10;
		critics: 15.
	collector add: item2 to: #owned.
	self assert: (collector collectionNamed: #owned) size equals: 2.
	self
		assert: (collector select: [ :each | each hasDocumentation ])
		equals: {item2} asOrderedCollection
]
