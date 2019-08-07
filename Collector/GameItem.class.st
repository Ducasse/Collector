Class {
	#name : #GameItem,
	#superclass : #Object,
	#instVars : [
		'console',
		'hasDocumentation',
		'hasBox',
		'finished',
		'condition',
		'quotation',
		'critics',
		'comments',
		'bought',
		'cover',
		'coverUrlPart',
		'title'
	],
	#classVars : [
		'Consoles'
	],
	#category : #'Collector-Core'
}

{ #category : #constant }
GameItem class >> DS [

	^ #DS
]

{ #category : #constant }
GameItem class >> GBA [

	^ #GBA
]

{ #category : #constant }
GameItem class >> GameBoy [

	^ #GameBoy
]

{ #category : #constant }
GameItem class >> GameCube [

	^ #GameCube
]

{ #category : #constant }
GameItem class >> PS1 [
	^ #PS1
	
]

{ #category : #constant }
GameItem class >> PS2 [
	^ #PS2
	
]

{ #category : #constant }
GameItem class >> PS3 [
	^ #PS3
	
]

{ #category : #constant }
GameItem class >> PS4 [
	^ #PS4
	
]

{ #category : #constant }
GameItem class >> PSP [

	^ #PSP 
]

{ #category : #constant }
GameItem class >> TDS [

	^ #TDS
]

{ #category : #constant }
GameItem class >> Wii [

	^ #Wii
]

{ #category : #constant }
GameItem class >> WiiU [

	^ #WiiU
]

{ #category : #constant }
GameItem class >> badCondition [
	^ 'Bad'
]

{ #category : #constant }
GameItem class >> blisterCondition [
	^ 'Under blister'
]

{ #category : #constant }
GameItem class >> conditions [

	^ { self badCondition . self goodCondition . self veryGoodCondition . self blisterCondition}
]

{ #category : #constant }
GameItem class >> consoles [ 

	^ Consoles 
]

{ #category : #constant }
GameItem class >> declareConsoles [ 

	Consoles := { self PS4 . self PS3 . self PS2. self  PS1 . self PSP . self DS . self TDS . self Wii . self WiiU . self GameCube . self GameBoy. self GBA}
]

{ #category : #examples }
GameItem class >> finalFantasyX [
	<sampleInstance>
	^ GameItem new
		title: 'Final Fantasy X';
		hasDocumentation: false;
		finished: true;
		quotation: 10;
		setPS2;
		critics: 18;
		comments: 'quite cool in fact';
		coverUrlPart: 'finalfantasyx_eu'
]

{ #category : #examples }
GameItem class >> finalFantasyX2 [
	<sampleInstance>
	^ GameItem new
		title: 'Final Fantasy X2';
		hasDocumentation: true;
		finished: true;
		quotation: 20;
		setPS2;
		critics: 18;
		comments: 'quite cool in fact';
		coverUrlPart: 'finalfantasyx_eu'
]

{ #category : #'instance creation' }
GameItem class >> fromSTON: aString [ 
	^ STON fromString: aString
]

{ #category : #constant }
GameItem class >> goodCondition [

	^ 'Good'
]

{ #category : #initialize }
GameItem class >> initialize [
	"self initialize"

	self declareConsoles
]

{ #category : #constant }
GameItem class >> veryGoodCondition [
	^ 'Very Good'
]

{ #category : #'constant consoles' }
GameItem >> PS1 [
	self
		deprecated: 'Please use #assert:description: instead'
		transformWith: '`@receiver PS1' 
						-> '`@receiver setPS1'.
]

{ #category : #'constant consoles' }
GameItem >> PS2 [
	self
		deprecated: 'Please use #assert:description: instead'
		transformWith: '`@receiver PS2' 
						-> '`@receiver setPS2'.
]

{ #category : #'constant consoles' }
GameItem >> PS3 [
	self
		deprecated: 'Please use #assert:description: instead'
		transformWith: '`@receiver PS3' 
						-> '`@receiver setPS3'.
]

{ #category : #'constant consoles' }
GameItem >> PS4 [
	self
		deprecated: 'Please use #assert:description: instead'
		transformWith: '`@receiver PS4' 
						-> '`@receiver setPS4'.
]

{ #category : #'constant consoles' }
GameItem >> PSP [
	self
		deprecated: 'Please use #assert:description: instead'
		transformWith: '`@receiver PSP' 
						-> '`@receiver setPSP'.
]

{ #category : #conversion }
GameItem >> asSTON [
	^ STON toStringPretty: self.
]

{ #category : #constant }
GameItem >> badCondition [
	condition := self class badCondition
]

{ #category : #accessing }
GameItem >> bought [

	^ bought
]

{ #category : #accessing }
GameItem >> bought: anInteger [
	bought := anInteger
]

{ #category : #accessing }
GameItem >> comments [
	^ comments .
]

{ #category : #accessing }
GameItem >> comments: aString [ 
	comments := aString
]

{ #category : #accessing }
GameItem >> condition [
	^ condition
]

{ #category : #accessing }
GameItem >> console [
	^ console
]

{ #category : #accessing }
GameItem >> coverUrl [
	^ 'http://www.thecoverproject.net/images/covers/' , self console asLowercase , '_' , self coverUrlPart , '_thumb.jpg'
]

{ #category : #accessing }
GameItem >> coverUrlPart [
	^ coverUrlPart
]

{ #category : #accessing }
GameItem >> coverUrlPart: aString [ 
	coverUrlPart := aString
]

{ #category : #accessing }
GameItem >> critics [
	^critics
]

{ #category : #accessing }
GameItem >> critics: anInteger [ 
	critics := anInteger
]

{ #category : #'cover fetching logic' }
GameItem >> fetchCover [
	
	(coverUrlPart isNil or: [ coverUrlPart = self urlPartIsNetworkError ])
		ifTrue: [ coverUrlPart := self guessUrlPart ].
	[ [ ^ ZnEasy getJpeg: self coverUrl ]
		on: ZnHttpUnsuccessful
		do: [ coverUrlPart := self wrongUrlPart ] ]
		on: NetworkError
		do: [ coverUrlPart := self urlPartIsNetworkError ]
]

{ #category : #accessing }
GameItem >> finished [
	^ finished
]

{ #category : #accessing }
GameItem >> finished: aBoolean [ 
	finished := aBoolean
]

{ #category : #'constant consoles' }
GameItem >> gameCube [
	self
		deprecated: 'Please use #assert:description: instead'
		transformWith: '`@receiver gameCube' 
						-> '`@receiver setGameCube'.
]

{ #category : #constant }
GameItem >> goodCondition [
	condition := self class goodCondition.
]

{ #category : #'cover fetching logic' }
GameItem >> guessUrlPart [
	^ ((self title asLowercase copyWithoutAll: ';,- :''') 
		copyReplaceAll: '!' with: '-')
		copyReplaceAll: '&'
		with: 'and'
]

{ #category : #accessing }
GameItem >> hasBox [
	^ hasBox 
]

{ #category : #accessing }
GameItem >> hasBox: aBoolean [ 
	hasBox := aBoolean
]

{ #category : #accessing }
GameItem >> hasDocumentation [
	^ hasDocumentation
]

{ #category : #accessing }
GameItem >> hasDocumentation: aBoolean [
	hasDocumentation := aBoolean
]

{ #category : #initialization }
GameItem >> initialize [
	super initialize.
	hasDocumentation := true.
	hasBox := true.
	finished := false.
	condition := self class goodCondition.
	quotation := 0.
	critics := 0.
	comments := ''
]

{ #category : #testing }
GameItem >> isBadCondition [
	^ condition = self class badCondition
]

{ #category : #testing }
GameItem >> isFinished [
	^ finished
]

{ #category : #testing }
GameItem >> isGoodCondition [
	^ condition = self class goodCondition
]

{ #category : #testing }
GameItem >> isValid [

	^ self title isNotNil and: [ self console isNotNil ]
]

{ #category : #testing }
GameItem >> isVeryGoodCondition [
	^ condition = self class veryGoodCondition
]

{ #category : #printing }
GameItem >> printOn: aStream [

	aStream 
		nextPutAll: self title;
		nextPutAll: ' - ';
		nextPutAll: self console asString
]

{ #category : #accessing }
GameItem >> quotation [
	^ quotation
]

{ #category : #accessing }
GameItem >> quotation: anInteger [ 
	quotation := anInteger
]

{ #category : #'cover fetching logic' }
GameItem >> setCover [
	cover := self fetchCover 
]

{ #category : #'constant consoles' }
GameItem >> setDS [
	console := self class setDS
]

{ #category : #'constant consoles' }
GameItem >> setGameCube [
	console := self class GameCube
]

{ #category : #'constant consoles' }
GameItem >> setPS1 [
	console := self class PS1
]

{ #category : #'constant consoles' }
GameItem >> setPS2 [
	console := self class PS2
]

{ #category : #'constant consoles' }
GameItem >> setPS3 [
	console := self class PS3
]

{ #category : #'constant consoles' }
GameItem >> setPS4 [
	console := self class PS4
]

{ #category : #'constant consoles' }
GameItem >> setPSP [
	console := self class PSP
]

{ #category : #'constant consoles' }
GameItem >> setThreeDS [
	console := self class TDS
]

{ #category : #'constant consoles' }
GameItem >> setWii [
	console := self class Wii
]

{ #category : #'constant consoles' }
GameItem >> setWiiU [
	console := self class WiiU
]

{ #category : #'constant consoles' }
GameItem >> threeDS [
	self
		deprecated: 'Please use #assert:description: instead'
		transformWith: '`@receiver threeDS' 
						-> '`@receiver setThreeDS'.
]

{ #category : #accessing }
GameItem >> title [ 
	^ title
]

{ #category : #accessing }
GameItem >> title: aString [ 
	title := aString
]

{ #category : #'cover fetching logic' }
GameItem >> urlPartIsNetworkError [

	^ 'no network'
]

{ #category : #constant }
GameItem >> veryGoodCondition [
	condition := self class veryGoodCondition.
]

{ #category : #'constant consoles' }
GameItem >> wii [
	self
		deprecated: 'Please use #assert:description: instead'
		transformWith: '`@receiver wii' 
						-> '`@receiver setWii'.
]

{ #category : #'constant consoles' }
GameItem >> wiiU [
	self
		deprecated: 'Please use #assert:description: instead'
		transformWith: '`@receiver wiiU' 
						-> '`@receiver setWiiU'.
]

{ #category : #'cover fetching logic' }
GameItem >> wrongUrlPart [
	^ 'broken guessed url part'
]
