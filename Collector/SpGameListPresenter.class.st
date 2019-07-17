"
SpGameListPresenter new openWithSpec.

SpGameListPresenter new 
	on: GameCollector smallCollection;
	openWithSpec
"
Class {
	#name : #SpGameListPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'items',
		'listModel',
		'collector'
	],
	#category : #'Collector-UI'
}

{ #category : #specs }
SpGameListPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
			add: #listModel;
			yourself
]

{ #category : #specs }
SpGameListPresenter class >> title [
	^ 'Collector'
]

{ #category : #initialization }
SpGameListPresenter >> initializeWidgets [
	listModel := self newList.
	listModel sortingBlock: [ :assocA :assocB | assocA title < assocB title ].
	listModel displayBlock: [ :assoc | assoc title ].
	self focusOrder add: listModel.
]

{ #category : #initialization }
SpGameListPresenter >> listModel [
	^ listModel
]

{ #category : #initialization }
SpGameListPresenter >> on: aGameCollector [
	collector := aGameCollector.
	listModel items: (collector collectionNamed: #owned).

]

{ #category : #initialization }
SpGameListPresenter >> title [

	^ 'Games'
]

{ #category : #initialization }
SpGameListPresenter >> whenSelectedItemChanged: aBlock [
  	listModel whenSelectedItemChanged: aBlock
]
