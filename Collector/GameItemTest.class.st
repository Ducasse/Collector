Class {
	#name : #GameItemTest,
	#superclass : #TestCase,
	#instVars : [
		'gameItem'
	],
	#category : #'Collector-Tests'
}

{ #category : #tests }
GameItemTest >> testConsole [
	| ff |
	ff := CGameItem finalFantasyX setPS2.
	self assert: ff console equals: CGameItem PS2
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
	item := CGameItem fromSTON: string.
	ff := CGameItem finalFantasyX.
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
	item := CGameItem finalFantasyX.
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
	item := CGameItem new 
					title: 'Final Fantasy X'.
	self assert: item title equals: 'Final Fantasy X'.				
]

{ #category : #'tests - url for fetching cover' }
GameItemTest >> testGuessUrlPart [
	| dg8 |
	dg8 := CGameItem new
		title: 'Dragon Quest VIII: Journey Of The Cursed King';
		setPS2.
	self
		assert: dg8 guessUrlPart
		equals: 'dragonquestviiijourneyofthecursedking'
]

{ #category : #'tests - url for fetching cover' }
GameItemTest >> testGuessUrlPartWithQuoteAndExclamationMark [
	| zb |
	zb := CGameItem new
		title: 'Zat-ch Bell!: Mamodo Battles';
		setPS2.
	self assert: zb guessUrlPart equals: 'zatchbell-mamodobattles'
]

{ #category : #tests }
GameItemTest >> testInitialize [
	| item |
	item := CGameItem new.
	self assert: item title isNil.
	self assert: item console isNil.
	self assert: item hasDocumentation equals: true.
	self assert: item hasBox equals: true.
	self assert: item isFinished equals: false.
	self assert: item condition equals: CGameItem goodCondition.
	self assert: item quotation equals: 0.
	self assert: item critics equals: 0.
	self assert: item comments equals: ''
]

{ #category : #tests }
GameItemTest >> testIsBad [
	| item |
	item := CGameItem new
		title: 'Final Fantasy X';
		badCondition.
	self assert: item condition equals: CGameItem badCondition
]

{ #category : #tests }
GameItemTest >> testIsGood [
	| item |
	item := CGameItem new
		title: 'Final Fantasy X';
		goodCondition.
	self assert: item condition equals: CGameItem goodCondition.
]

{ #category : #tests }
GameItemTest >> testIsValid [
	| ff |
	ff := CGameItem finalFantasyX setPS2.
	self assert: ff isValid.
	
	ff := CGameItem new title: 'Final Fantasy X'.
	self deny: ff isValid
]

{ #category : #tests }
GameItemTest >> testIsVeryGood [
	| item |
	item := CGameItem new
		title: 'Final Fantasy X';
		veryGoodCondition.
	self assert: item condition equals: CGameItem veryGoodCondition
]

{ #category : #tests }
GameItemTest >> testPrintOnUpgraded [
	| item |
	item := CGameItem new
		title: 'Final Fantasy X';
		setPS1;
		hasDocumentation: false;
		finished: true;
		quotation: 10;
		critics: 18.
	self assert: item printString equals: 'Final Fantasy X - PS1'
]

{ #category : #tests }
GameItemTest >> testTwoItemsCanHaveTheSameName [
	| item1 item2 |
	item1 := CGameItem new
		title: 'Final Fantasy X';
		setPS1;
		hasDocumentation: false.
		
	item2 := CGameItem new 
		title: 'Final Fantasy X';
		setPS1;
		hasDocumentation: true.
		
	self deny: item1 = item2
]

{ #category : #tests }
GameItemTest >> testTwoItemsWithSameNameButDifferentConsolesAreDifferent [
	"this is obvious since we do not redefine = but better be sure"
	| item1 item2 |
	item1 := CGameItem new
		title: 'Final Fantasy X';
		setPS2;
		hasDocumentation: false.
		
	item2 := CGameItem new 
		title: 'Final Fantasy X';
		setPS1;
		hasDocumentation: true.
		
	self deny: item1 = item2
]

{ #category : #'tests - url for fetching cover' }
GameItemTest >> testUrl [
	self
		assert: (CGameItem finalFantasyX coverUrlPart: 'finalfantasyx_eu') coverUrl
		equals: 'http://www.thecoverproject.net/images/covers/ps2_finalfantasyx_eu_thumb.jpg'
]

{ #category : #'tests - url for fetching cover' }
GameItemTest >> testWrongGuessedUrlPart [
	| g |
	g := CGameItem new
		title: 'Jak II';
		setPS2.
	g fetchCover.
	self assert: g coverUrlPart equals: g wrongUrlPart
]
