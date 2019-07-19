"
SpGameListPresenter new openWithSpec.

SpGameListPresenter new 
	on: (GameCollector smallCollection collectionNamed: #owned);
	openWithSpec
"
Class {
	#name : #SpGameListPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'items',
		'listModel',
		'collector',
		'classItem'
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
	listModel sortingBlock: [ :cls1 :cls2 | cls1 title < cls2 title ]
]

{ #category : #initialization }
SpGameListPresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter title: 'List of Games'
]

{ #category : #accessing }
SpGameListPresenter >> listModel [ 
	^ listModel
]

{ #category : #accessing }
SpGameListPresenter >> on: aCollection [
	listModel items: aCollection
]

{ #category : #initialization }
SpGameListPresenter >> title [

	^ 'Games'
]

{ #category : #initialization }
SpGameListPresenter >> whenSelectedItemChanged: aBlock [
  	listModel whenSelectedItemChanged: aBlock
]
