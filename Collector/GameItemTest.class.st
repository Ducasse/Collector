Class {
	#name : #GameItemTest,
	#superclass : #TestCase,
	#category : #'Collector-Tests'
}

{ #category : #tests }
GameItemTest >> testConsole [
	| ff |
	ff := GameItem finalFantasyX PS2.
	self assert: ff console equals: GameItem PS2
]

{ #category : #tests }
GameItemTest >> testConversionFromSTON [
	| string item ff |
	string := 'GameItem {
	#console : #PS2,
	#hasDocumentation : false,
	#hasBox : true,
	#finished : true,
	#condition : ''Good'',
	#quotation : 10,
	#critics : 18,
	#comments : ''quite cool in fact'',
	#title : ''Final Fantasy X''
}'.
	item := GameItem fromSTON: string.
	ff := GameItem finalFantasyX.
	self assert: item title equals: ff title.
	self assert: item console equals: ff console.
	self assert: item hasDocumentation equals: ff hasDocumentation.
	self assert: item hasBox equals: ff hasBox.
	self assert: item finished equals: ff finished.
	self assert: item condition equals: ff condition.
	self assert: item quotation equals: ff quotation.
	self assert: item critics equals: ff critics.
	self assert: item comments equals: ff comments
]

{ #category : #tests }
GameItemTest >> testConversionToSTON [
	| item |
	item := GameItem finalFantasyX.
	self
		assert: item asSTON
		equals:
			'GameItem {
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
}'
]

{ #category : #tests }
GameItemTest >> testGameItemHasAtLeastAName [

	| item |
	item := GameItem new 
					title: 'Final Fantasy X'.
	self assert: item title equals: 'Final Fantasy X'.				
]

{ #category : #'tests - url for fetching cover' }
GameItemTest >> testGuessUrlPart [
	| dg8 |
	dg8 := GameItem new
		title: 'Dragon Quest VIII: Journey Of The Cursed King';
		PS2.
	self assert: dg8 guessUrlPart equals: 'dragonquestviiijourneyofthecursedking'
]

{ #category : #'tests - url for fetching cover' }
GameItemTest >> testGuessUrlPartWithQuoteAndExclamationMark [
	| zb |
	zb := GameItem new
		title: 'Zat-ch Bell!: Mamodo Battles';
		PS2.
	self assert: zb guessUrlPart equals: 'zatchbell-mamodobattles'
]

{ #category : #tests }
GameItemTest >> testInitialize [
	| item |
	item := GameItem new.
	self assert: item title equals: ''.
	self assert: item console equals: ''.
	self assert: item hasDocumentation equals: true.
	self assert: item hasBox equals: true.
	self assert: item isFinished equals: false.
	self assert: item condition = GameItem goodCondition.
	self assert: item quotation equals: 0.
	self assert: item critics equals: 0.
	self assert: item comments equals: ''
]

{ #category : #tests }
GameItemTest >> testIsBad [
	| item |
	item := GameItem new
		title: 'Final Fantasy X';
		badCondition.
	self assert: item condition equals: GameItem badCondition
]

{ #category : #tests }
GameItemTest >> testIsGood [
	| item |
	item := GameItem new
		title: 'Final Fantasy X';
		goodCondition.
	self assert: item condition equals: GameItem goodCondition.
]

{ #category : #tests }
GameItemTest >> testIsVeryGood [
	| item |
	item := GameItem new
		title: 'Final Fantasy X';
		veryGoodCondition.
	self assert: item condition equals: GameItem veryGoodCondition
]

{ #category : #tests }
GameItemTest >> testPrintOnUpgraded [
	| item |
	item := GameItem new
		title: 'Final Fantasy X';
		hasDocumentation: false;
		finished: true;
		quotation: 10;
		critics: 18.
	self assert: item printString equals: 'a GameItem (Final Fantasy X)'
]

{ #category : #tests }
GameItemTest >> testTwoItemsCanHaveTheSameName [
	| item1 item2 |
	item1 := GameItem new
		title: 'Final Fantasy X';
		hasDocumentation: false.
		
	item2 := GameItem new 
		title: 'Final Fantasy X';
		hasDocumentation: true.
		
	self deny: item1 = item2
]

{ #category : #'tests - url for fetching cover' }
GameItemTest >> testUrl [
	self
		assert: (GameItem finalFantasyX coverUrlPart: 'finalfantasyx_eu') coverUrl
		equals: 'http://www.thecoverproject.net/images/covers/ps2_finalfantasyx_eu_thumb.jpg'
]

{ #category : #'tests - url for fetching cover' }
GameItemTest >> testWrongGuessedUrlPart [

	| g |
	g := GameItem new title: 'Jak II'; PS2.
	g fetchCover.
	self assert: g coverUrlPart equals: g wrongUrlPart 
]
