"
SpGameItemDisplayer new openWithSpec
"
Class {
	#name : #SpGameItemDisplayer,
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
SpGameItemDisplayer class >> defaultSpec [
	^ SpBoxLayout newVertical 
			add: #titleNameTextModel;
			yourself 
			
	"		
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
		
		"
]

{ #category : #initialization }
SpGameItemDisplayer >> initializeWidgets [
	titleNameTextModel := self newTextInput.
	titleNameTextModel placeholder: 'Name of game'.
	"
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
	"
]

{ #category : #accessing }
SpGameItemDisplayer >> titleNameTextModel [

	^ titleNameTextModel
]
