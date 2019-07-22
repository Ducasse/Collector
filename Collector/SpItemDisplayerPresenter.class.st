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
	^ SpBoxLayout newHorizontal 
			add: #titleNameTextModel;
			yourself
			"col
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
		yourself"
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
]
