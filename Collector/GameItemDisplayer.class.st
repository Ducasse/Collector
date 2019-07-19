"
GameItemDisplayer new 
	gameItem: GameItem finalFantasyX; 
	openWithSpec
	
GameItemDisplayer new 
	openWithSpec
"
Class {
	#name : #GameItemDisplayer,
	#superclass : #ComposablePresenter,
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
GameItemDisplayer class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :col | 
			col add: #titleNameTextModel height: self inputTextHeight.
			col
				newRow: [ :row | 
					row add: #consoleDropListModel width: 100.
					row add: #criticsTextModel width: 30.
						row newColumn: [ :e |  ].
					row add: #quotationTextModel width: 30.
					row newColumn: [ :e |  ].
					row add: #conditionDropListModel width: 100 ]
				height: self inputTextHeight.
			col
				newRow: [ :row | 
					row add: #hasDocCheckBoxModel.
					row add: #finishedCheckBoxModel.
					row add: #hasBoxCheckBoxModel ]
				height: self inputTextHeight.
			col add: #commentsTextModel height: self inputTextHeight * 4.
			col newRow: [ :e |  ] ];
		yourself
]

{ #category : #specs }
GameItemDisplayer class >> inputCharWidth [
	^ 16
]

{ #category : #'widget accessing' }
GameItemDisplayer >> commentsTextModel [

	^ commentsTextModel 
]

{ #category : #'widget accessing' }
GameItemDisplayer >> conditionDropListModel [ 

	^ conditionDropListModel 
]

{ #category : #'widget accessing' }
GameItemDisplayer >> consoleDropListModel [ 
	^ consoleDropListModel 
]

{ #category : #'widget accessing' }
GameItemDisplayer >> criticsTextModel [

	^ criticsTextModel 
]

{ #category : #spec }
GameItemDisplayer >> extent [
	^ 280 @ 260
]

{ #category : #'widget accessing' }
GameItemDisplayer >> finishedCheckBoxModel [ 

	^ finishedCheckBoxModel 
]

{ #category : #'domain object' }
GameItemDisplayer >> gameItem: aNewGameItem [

	gameItem value: aNewGameItem
]

{ #category : #initialization }
GameItemDisplayer >> gameItemChanged [
	titleNameTextModel text: gameItem value title.
	consoleDropListModel selectedItem: gameItem value console.
	conditionDropListModel selectedItem: gameItem value condition.
	hasDocCheckBoxModel state: gameItem value hasDocumentation.
	finishedCheckBoxModel state: gameItem value finished.
	quotationTextModel text: gameItem value quotation.
	commentsTextModel text: gameItem value comments.
	criticsTextModel text: gameItem value critics
]

{ #category : #'widget accessing' }
GameItemDisplayer >> hasBoxCheckBoxModel [ 

	^ hasBoxCheckBoxModel 
]

{ #category : #'widget accessing' }
GameItemDisplayer >> hasDocCheckBoxModel [ 
	^ hasDocCheckBoxModel
	
	
]

{ #category : #initialization }
GameItemDisplayer >> initialize [
	"All the element with be based on the gameItem"

	gameItem := nil asValueHolder.
	"order important since initialize will invoke initialiseWidgets and initializePresenter. In the future we should have initializeSubject: "
	super initialize.

]

{ #category : #initialization }
GameItemDisplayer >> initializePresenter [

	gameItem
		whenChangedDo: [ self gameItemChanged ]
]

{ #category : #initialization }
GameItemDisplayer >> initializeWidgets [
	titleNameTextModel := self newTextInput.
	titleNameTextModel placeholder: 'Name of game'.
	self setConsoleDropList.
	self setHasDocCheckBox.
	self setHasBoxCheckBox.
	self setFinishCheckBox.
	self setConditionDropList.
	quotationTextModel := self newTextInput.
	quotationTextModel placeholder: 'in Euros'.
	criticsTextModel := self newTextInput.
	criticsTextModel placeholder: ' x / 20 '.
	commentsTextModel := self newTextInput.
	criticsTextModel placeholder: ' May be you want to add something... '
]

{ #category : #'domain object' }
GameItemDisplayer >> on: aNewGameItem [

	gameItem value: aNewGameItem
]

{ #category : #'widget accessing' }
GameItemDisplayer >> quotationTextModel [ 
	^ quotationTextModel 
]

{ #category : #initialization }
GameItemDisplayer >> setConditionDropList [
	conditionDropListModel := self newDropList.
	conditionDropListModel items: GameItem conditions.
	conditionDropListModel displayBlock: [ :m | m asString ]
]

{ #category : #initialization }
GameItemDisplayer >> setConsoleDropList [
	consoleDropListModel := self newDropList.
	consoleDropListModel items: GameItem consoles.
	consoleDropListModel displayBlock: [ :m | m ]
]

{ #category : #initialization }
GameItemDisplayer >> setFinishCheckBox [
	finishedCheckBoxModel := self newCheckBox.
	finishedCheckBoxModel label: 'Finished'
]

{ #category : #initialization }
GameItemDisplayer >> setHasBoxCheckBox [
	hasBoxCheckBoxModel := self newCheckBox.
	hasBoxCheckBoxModel label: 'Box'
]

{ #category : #initialization }
GameItemDisplayer >> setHasDocCheckBox [
	hasDocCheckBoxModel := self newCheckBox.
	hasDocCheckBoxModel label: 'Doc'
]

{ #category : #spec }
GameItemDisplayer >> title [

	^ 'Game'
]

{ #category : #'widget accessing' }
GameItemDisplayer >> titleNameTextModel [
	^ titleNameTextModel
]
