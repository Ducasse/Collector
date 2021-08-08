"
SpItemDisplayerPresenter new 
	gameItem: GameItem finalFantasyX; 
	openWithSpec
	
SpItemDisplayerPresenter new 
	openWithSpec
"
Class {
	#name : #SpItemDisplayerPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'#gameItem => SpObservableSlot',
		'#consoleDropListModel',
		'#hasDocCheckBoxModel',
		'#hasBoxCheckBoxModel',
		'#finishedCheckBoxModel',
		'#conditionDropListModel',
		'#commentsTextModel',
		'#titleNameTextModel',
		'#criticsNumberModel',
		'#quotationNumberModel'
	],
	#category : #'Collector-UI'
}

{ #category : #specs }
SpItemDisplayerPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #titleNameTextModel
			expand: false
			fill: false
			padding: 5;
		add: #consoleDropListModel
			expand: false
			fill: false
			padding: 5;
		add: #criticsNumberModel
			expand: false
			fill: false
			padding: 5;
		add:
			(SpBoxLayout newHorizontal
					add: #hasDocCheckBoxModel;
					add: #hasBoxCheckBoxModel;
					add: #finishedCheckBoxModel;
					yourself)
			expand: false
			fill: false
			padding: 5;
		add: #quotationNumberModel
			expand: false
			fill: false
			padding: 5;
		add: #conditionDropListModel
			expand: false
			fill: false
			padding: 5;
		add: #commentsTextModel;
		yourself
]

{ #category : #examples }
SpItemDisplayerPresenter class >> example [
	self new
		gameItem: CGameItem finalFantasyX;
		openWithSpec
]

{ #category : #accessing }
SpItemDisplayerPresenter >> gameItem: aNewGameItem [
	gameItem := aNewGameItem
]

{ #category : #initialization }
SpItemDisplayerPresenter >> gameItemChanged [
	titleNameTextModel text: gameItem title.
	consoleDropListModel selectItem: gameItem console.
	conditionDropListModel selectItem: gameItem condition.
	hasDocCheckBoxModel state: gameItem hasDocumentation.
	finishedCheckBoxModel state: gameItem finished.
	quotationNumberModel number: gameItem quotation.
	commentsTextModel text: gameItem comments.
	criticsNumberModel number: gameItem critics
]

{ #category : #accessing }
SpItemDisplayerPresenter >> hasDocCheckBoxModel [
	^ hasDocCheckBoxModel
]

{ #category : #initialization }
SpItemDisplayerPresenter >> initialize [
	super initialize.
]

{ #category : #initialization }
SpItemDisplayerPresenter >> initializePresenter [
	self property: #gameItem whenChangedDo: [ self gameItemChanged ]
]

{ #category : #initialization }
SpItemDisplayerPresenter >> initializeWidgets [
	titleNameTextModel := self newTextInput.
	titleNameTextModel placeholder: 'Name of game'.
	self setConsoleDropList.
	criticsNumberModel := self newNumberInput.
	criticsNumberModel placeholder: ' x / 20 '.
	self setHasDocCheckBox.
	self setHasBoxCheckBox.
	self setFinishCheckBox.
	self setConditionDropList.
	quotationNumberModel := self newNumberInput.
	quotationNumberModel placeholder: 'in Euros'.
	commentsTextModel := self newText.
	"commentsTextModel placeholder: ' May be you want to add something... '"
]

{ #category : #initialization }
SpItemDisplayerPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter title: 'Game Displayer'
]

{ #category : #accessing }
SpItemDisplayerPresenter >> quotationNumberModel [
	^ quotationNumberModel
]

{ #category : #initialization }
SpItemDisplayerPresenter >> setConditionDropList [
	conditionDropListModel := self newDropList.
	conditionDropListModel items: CGameItem conditions.
	conditionDropListModel display: [ :m | m asString ]
]

{ #category : #initialization }
SpItemDisplayerPresenter >> setConsoleDropList [
	consoleDropListModel := self newDropList.
	consoleDropListModel items: CGameItem consoles.
	consoleDropListModel display: [ :m | m ]
]

{ #category : #initialization }
SpItemDisplayerPresenter >> setFinishCheckBox [
	finishedCheckBoxModel := self newCheckBox.
	finishedCheckBoxModel label: 'Finished'
]

{ #category : #initialization }
SpItemDisplayerPresenter >> setHasBoxCheckBox [
	hasBoxCheckBoxModel := self newCheckBox.
	hasBoxCheckBoxModel label: 'Box'
]

{ #category : #initialization }
SpItemDisplayerPresenter >> setHasDocCheckBox [
	hasDocCheckBoxModel := self newCheckBox.
	hasDocCheckBoxModel label: 'Doc'
]
