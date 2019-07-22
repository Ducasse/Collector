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
		'gameItem',
		'consoleDropListModel',
		'hasDocCheckBoxModel',
		'hasBoxCheckBoxModel',
		'finishedCheckBoxModel',
		'conditionDropListModel',
		'commentsTextModel',
		'titleNameTextModel',
		'criticsTextModel',
		'quotationTextModel'
	],
	#category : #'Collector-UI'
}

{ #category : #specs }
SpItemDisplayerPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical 
			add: #titleNameTextModel;
			add: #consoleDropListModel;
			add: #criticsTextModel;
			add: #hasDocCheckBoxModel;
			add: #hasBoxCheckBoxModel;
			add: #finishedCheckBoxModel;
			add: #quotationTextModel;
			add: #conditionDropListModel;
			add: #commentsTextModel;
			yourself
			
]

{ #category : #accessing }
SpItemDisplayerPresenter >> gameItem: aNewGameItem [

	gameItem value: aNewGameItem
]

{ #category : #initialization }
SpItemDisplayerPresenter >> gameItemChanged [
	titleNameTextModel text: gameItem value title.
]

{ #category : #initialization }
SpItemDisplayerPresenter >> initialize [
	"All the element with be based on the gameItem"

	gameItem := nil asValueHolder.
	"order important since initialize will invoke initialiseWidgets and initializePresenter. In the future we should have initializeSubject: "
	super initialize.

]

{ #category : #initialization }
SpItemDisplayerPresenter >> initializePresenter [

	gameItem
		whenChangedDo: [ self gameItemChanged ]
]

{ #category : #initialization }
SpItemDisplayerPresenter >> initializeWidgets [
	titleNameTextModel := self newTextInput.
	titleNameTextModel placeholder: 'Name of game'.
	self setConsoleDropList.
	criticsTextModel := self newTextInput.
	criticsTextModel placeholder: ' x / 20 '.
	self setHasDocCheckBox.
	self setHasBoxCheckBox.
	self setFinishCheckBox.
	self setConditionDropList.
	quotationTextModel := self newTextInput.
	quotationTextModel placeholder: 'in Euros'.
	commentsTextModel := self newTextInput.
	commentsTextModel placeholder: ' May be you want to add something... '
]

{ #category : #initialization }
SpItemDisplayerPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter title: 'Game Displayer'
]

{ #category : #initialization }
SpItemDisplayerPresenter >> setConditionDropList [
	conditionDropListModel := self newDropList.
	conditionDropListModel items: GameItem conditions.
	conditionDropListModel displayBlock: [ :m | m asString ]
]

{ #category : #initialization }
SpItemDisplayerPresenter >> setConsoleDropList [
	consoleDropListModel := self newDropList.
	consoleDropListModel items: GameItem consoles.
	consoleDropListModel displayBlock: [ :m | m ]
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
