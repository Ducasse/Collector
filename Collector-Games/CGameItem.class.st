Class {
	#name : #CGameItem,
	#superclass : #CObject,
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
	#category : #'Collector-Games'
}

{ #category : #constant }
CGameItem class >> DS [

	^ #DS
]

{ #category : #constant }
CGameItem class >> GBA [

	^ #GBA
]

{ #category : #constant }
CGameItem class >> GameBoy [

	^ #GameBoy
]

{ #category : #constant }
CGameItem class >> GameCube [

	^ #GameCube
]

{ #category : #constant }
CGameItem class >> PS1 [
	^ #PS1
	
]

{ #category : #constant }
CGameItem class >> PS2 [
	^ #PS2
	
]

{ #category : #constant }
CGameItem class >> PS3 [
	^ #PS3
	
]

{ #category : #constant }
CGameItem class >> PS4 [
	^ #PS4
	
]

{ #category : #constant }
CGameItem class >> PSP [

	^ #PSP 
]

{ #category : #constant }
CGameItem class >> TDS [

	^ #TDS
]

{ #category : #constant }
CGameItem class >> Wii [

	^ #Wii
]

{ #category : #constant }
CGameItem class >> WiiU [

	^ #WiiU
]

{ #category : #constant }
CGameItem class >> badCondition [
	^ 'Bad'
]

{ #category : #constant }
CGameItem class >> blisterCondition [
	^ 'Under blister'
]

{ #category : #constant }
CGameItem class >> conditions [

	^ { self badCondition . self goodCondition . self veryGoodCondition . self blisterCondition}
]

{ #category : #constant }
CGameItem class >> consoles [ 

	^ Consoles 
]

{ #category : #constant }
CGameItem class >> declareConsoles [ 

	Consoles := { self PS4 . self PS3 . self PS2. self  PS1 . self PSP . self DS . self TDS . self Wii . self WiiU . self GameCube . self GameBoy. self GBA}
]

{ #category : #examples }
CGameItem class >> finalFantasyX [
	<sampleInstance>
	^ CGameItem new
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
CGameItem class >> finalFantasyX2 [
	<sampleInstance>
	^ CGameItem new
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
CGameItem class >> fromSTON: aString [ 
	^ STON fromString: aString
]

{ #category : #constant }
CGameItem class >> goodCondition [

	^ 'Good'
]

{ #category : #initialize }
CGameItem class >> initialize [
	"self initialize"

	self declareConsoles
]

{ #category : #constant }
CGameItem class >> veryGoodCondition [
	^ 'Very Good'
]

{ #category : #'constant consoles' }
CGameItem >> PS1 [
	self
		deprecated: 'Please use #assert:description: instead'
		transformWith: '`@receiver PS1' 
						-> '`@receiver setPS1'.
]

{ #category : #'constant consoles' }
CGameItem >> PS2 [
	self
		deprecated: 'Please use #assert:description: instead'
		transformWith: '`@receiver PS2' 
						-> '`@receiver setPS2'.
]

{ #category : #'constant consoles' }
CGameItem >> PS3 [
	self
		deprecated: 'Please use #assert:description: instead'
		transformWith: '`@receiver PS3' 
						-> '`@receiver setPS3'.
]

{ #category : #'constant consoles' }
CGameItem >> PS4 [
	self
		deprecated: 'Please use #assert:description: instead'
		transformWith: '`@receiver PS4' 
						-> '`@receiver setPS4'.
]

{ #category : #'constant consoles' }
CGameItem >> PSP [
	self
		deprecated: 'Please use #assert:description: instead'
		transformWith: '`@receiver PSP' 
						-> '`@receiver setPSP'.
]

{ #category : #conversion }
CGameItem >> asSTON [
	^ STON toStringPretty: self.
]

{ #category : #constant }
CGameItem >> badCondition [
	condition := self class badCondition
]

{ #category : #accessing }
CGameItem >> bought [

	^ bought
]

{ #category : #accessing }
CGameItem >> bought: anInteger [
	bought := anInteger
]

{ #category : #accessing }
CGameItem >> comments [
	^ comments .
]

{ #category : #accessing }
CGameItem >> comments: aString [ 
	comments := aString
]

{ #category : #accessing }
CGameItem >> condition [
	^ condition
]

{ #category : #accessing }
CGameItem >> console [
	^ console
]

{ #category : #accessing }
CGameItem >> coverUrl [
	^ 'http://www.thecoverproject.net/images/covers/' , self console asLowercase , '_' , self coverUrlPart , '_thumb.jpg'
]

{ #category : #accessing }
CGameItem >> coverUrlPart [
	^ coverUrlPart
]

{ #category : #accessing }
CGameItem >> coverUrlPart: aString [ 
	coverUrlPart := aString
]

{ #category : #accessing }
CGameItem >> critics [
	^critics
]

{ #category : #accessing }
CGameItem >> critics: anInteger [ 
	critics := anInteger
]

{ #category : #'cover fetching logic' }
CGameItem >> fetchCover [
	
	(coverUrlPart isNil or: [ coverUrlPart = self urlPartIsNetworkError ])
		ifTrue: [ coverUrlPart := self guessUrlPart ].
	[ [ ^ ZnEasy getJpeg: self coverUrl ]
		on: ZnHttpUnsuccessful
		do: [ coverUrlPart := self wrongUrlPart ] ]
		on: NetworkError
		do: [ coverUrlPart := self urlPartIsNetworkError ]
]

{ #category : #accessing }
CGameItem >> finished [
	^ finished
]

{ #category : #accessing }
CGameItem >> finished: aBoolean [ 
	finished := aBoolean
]

{ #category : #'constant consoles' }
CGameItem >> gameCube [
	self
		deprecated: 'Please use #assert:description: instead'
		transformWith: '`@receiver gameCube' 
						-> '`@receiver setGameCube'.
]

{ #category : #constant }
CGameItem >> goodCondition [
	condition := self class goodCondition.
]

{ #category : #'cover fetching logic' }
CGameItem >> guessUrlPart [
	^ ((self title asLowercase copyWithoutAll: ';,- :''') 
		copyReplaceAll: '!' with: '-')
		copyReplaceAll: '&'
		with: 'and'
]

{ #category : #accessing }
CGameItem >> hasBox [
	^ hasBox 
]

{ #category : #accessing }
CGameItem >> hasBox: aBoolean [ 
	hasBox := aBoolean
]

{ #category : #accessing }
CGameItem >> hasDocumentation [
	^ hasDocumentation
]

{ #category : #accessing }
CGameItem >> hasDocumentation: aBoolean [
	hasDocumentation := aBoolean
]

{ #category : #initialization }
CGameItem >> initialize [
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
CGameItem >> isBadCondition [
	^ condition = self class badCondition
]

{ #category : #testing }
CGameItem >> isFinished [
	^ finished
]

{ #category : #testing }
CGameItem >> isGoodCondition [
	^ condition = self class goodCondition
]

{ #category : #testing }
CGameItem >> isValid [

	^ self title isNotNil and: [ self console isNotNil ]
]

{ #category : #testing }
CGameItem >> isVeryGoodCondition [
	^ condition = self class veryGoodCondition
]

{ #category : #accessing }
CGameItem >> price [
	^ bought 
]

{ #category : #accessing }
CGameItem >> price: anInteger [
	bought := anInteger
]

{ #category : #printing }
CGameItem >> printOn: aStream [

	aStream 
		nextPutAll: self title;
		nextPutAll: ' - ';
		nextPutAll: self console asString
]

{ #category : #accessing }
CGameItem >> quotation [
	^ quotation
]

{ #category : #accessing }
CGameItem >> quotation: anInteger [ 
	quotation := anInteger
]

{ #category : #'cover fetching logic' }
CGameItem >> setCover [
	cover := self fetchCover 
]

{ #category : #'constant consoles' }
CGameItem >> setDS [
	console := self class setDS
]

{ #category : #'constant consoles' }
CGameItem >> setGameCube [
	console := self class GameCube
]

{ #category : #'constant consoles' }
CGameItem >> setPS1 [
	console := self class PS1
]

{ #category : #'constant consoles' }
CGameItem >> setPS2 [
	console := self class PS2
]

{ #category : #'constant consoles' }
CGameItem >> setPS3 [
	console := self class PS3
]

{ #category : #'constant consoles' }
CGameItem >> setPS4 [
	console := self class PS4
]

{ #category : #'constant consoles' }
CGameItem >> setPSP [
	console := self class PSP
]

{ #category : #'constant consoles' }
CGameItem >> setThreeDS [
	console := self class TDS
]

{ #category : #'constant consoles' }
CGameItem >> setWii [
	console := self class Wii
]

{ #category : #'constant consoles' }
CGameItem >> setWiiU [
	console := self class WiiU
]

{ #category : #'constant consoles' }
CGameItem >> threeDS [
	self
		deprecated: 'Please use #assert:description: instead'
		transformWith: '`@receiver threeDS' 
						-> '`@receiver setThreeDS'.
]

{ #category : #accessing }
CGameItem >> title [ 
	^ title
]

{ #category : #accessing }
CGameItem >> title: aString [ 
	title := aString
]

{ #category : #'cover fetching logic' }
CGameItem >> urlPartIsNetworkError [

	^ 'no network'
]

{ #category : #constant }
CGameItem >> veryGoodCondition [
	condition := self class veryGoodCondition.
]

{ #category : #'constant consoles' }
CGameItem >> wii [
	self
		deprecated: 'Please use #assert:description: instead'
		transformWith: '`@receiver wii' 
						-> '`@receiver setWii'.
]

{ #category : #'constant consoles' }
CGameItem >> wiiU [
	self
		deprecated: 'Please use #assert:description: instead'
		transformWith: '`@receiver wiiU' 
						-> '`@receiver setWiiU'.
]

{ #category : #'cover fetching logic' }
CGameItem >> wrongUrlPart [
	^ 'broken guessed url part'
]
