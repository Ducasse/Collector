"
GameListModel new openWithSpec.

GameListModel new 
	on: GameCollector smallCollection;
	openWithSpec
"
Class {
	#name : #GameListModel,
	#superclass : #ComposablePresenter,
	#instVars : [
		'items',
		'listModel',
		'collector'
	],
	#category : #'Collector-UI'
}

{ #category : #specs }
GameListModel class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :column | 
			column
				add: #listModel];
		yourself
]

{ #category : #specs }
GameListModel class >> title [
	^ 'Collector'
]

{ #category : #initialization }
GameListModel >> initializeWidgets [
	listModel := self newList.
	listModel sortingBlock: [ :assocA :assocB | assocA title < assocB title ].
	listModel displayBlock: [ :assoc | assoc title ].
	self focusOrder add: listModel.
]

{ #category : #initialization }
GameListModel >> listModel [
	^ listModel
]

{ #category : #initialization }
GameListModel >> on: aGameCollector [
	collector := aGameCollector.
	listModel items: (collector collectionNamed: #owned).

]

{ #category : #initialization }
GameListModel >> title [

	^ 'Games'
]

{ #category : #initialization }
GameListModel >> whenSelectedItemChanged: aBlock [
  	listModel whenSelectedItemChanged: aBlock
]
