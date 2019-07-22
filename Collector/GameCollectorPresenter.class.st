"
GameCollectorModel  new 
	on: GameCollector smallCollection2;
	openWithSpec
	

- should add 
-- drop box (with the list of collections).
-- edit
-- save button.
"
Class {
	#name : #GameCollectorPresenter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'gameCollector',
		'listDisplayer',
		'gameItemDisplayer'
	],
	#category : #'Collector-UI'
}

{ #category : #specs }
GameCollectorPresenter class >> defaultSpec [
	^ SpecColumnLayout composed
		newRow: [ :row | 
			row
				add: #list;
				add: #gameItem;
				yourself ]; yourself
]

{ #category : #accessing }
GameCollectorPresenter >> gameItem [
	^ gameItemDisplayer
]

{ #category : #accessing }
GameCollectorPresenter >> gameItem: anObject [
	gameItemDisplayer := anObject
]

{ #category : #initialization }
GameCollectorPresenter >> initializePresenter [
	listDisplayer listModel whenSelectedItemChanged: [ :item | 
		 item ifNotNil: [gameItemDisplayer gameItem: item ]]
]

{ #category : #initialization }
GameCollectorPresenter >> initializeWidgets [
	listDisplayer := self instantiate: SpItemListPresenter.
	gameItemDisplayer := self instantiate: GameItemDisplayer.
	self focusOrder add: listDisplayer ; add: gameItemDisplayer 
]

{ #category : #accessing }
GameCollectorPresenter >> list [
	^ listDisplayer
]

{ #category : #accessing }
GameCollectorPresenter >> list: anObject [
	listDisplayer := anObject
]

{ #category : #accessing }
GameCollectorPresenter >> on: aGameCollector [
	gameCollector := aGameCollector.
	listDisplayer on: aGameCollector.
]
