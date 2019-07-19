"
SpItemListPresenter new openWithSpec.

SpItemListPresenter new 
	on: (GameCollector smallCollection collectionNamed: #owned);
	openWithSpec
"
Class {
	#name : #SpItemListPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'items',
		'listModel',
		'collector'
	],
	#category : #'Collector-UI'
}

{ #category : #specs }
SpItemListPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
			add: #listModel;
			yourself
]

{ #category : #specs }
SpItemListPresenter class >> title [
	^ 'Collector'
]

{ #category : #initialization }
SpItemListPresenter >> initializeWidgets [
	listModel := self newList.
	listModel sortingBlock: [ :cls1 :cls2 | cls1 title < cls2 title ]
]

{ #category : #initialization }
SpItemListPresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter title: 'List of Games'
]

{ #category : #accessing }
SpItemListPresenter >> listModel [ 
	^ listModel
]

{ #category : #accessing }
SpItemListPresenter >> on: aCollection [
	listModel items: aCollection
]

{ #category : #initialization }
SpItemListPresenter >> title [

	^ 'Games'
]

{ #category : #initialization }
SpItemListPresenter >> whenSelectedItemChanged: aBlock [
  	listModel whenSelectedItemChanged: aBlock
]
