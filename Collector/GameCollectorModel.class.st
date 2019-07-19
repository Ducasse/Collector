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
	#name : #GameCollectorModel,
	#superclass : #ComposablePresenter,
	#instVars : [
		'gameCollector',
		'listDisplayer',
		'gameItemDisplayer'
	],
	#category : #'Collector-UI'
}

{ #category : #specs }
GameCollectorModel class >> defaultSpec [
	^ SpecColumnLayout composed
		newRow: [ :row | 
			row
				add: #list;
				add: #gameItem;
				yourself ]; yourself
]

{ #category : #accessing }
GameCollectorModel >> gameItem [
	^ gameItemDisplayer
]

{ #category : #accessing }
GameCollectorModel >> gameItem: anObject [
	gameItemDisplayer := anObject
]

{ #category : #initialization }
GameCollectorModel >> initializePresenter [
	listDisplayer listModel whenSelectedItemChanged: [ :item | 
		 item ifNotNil: [gameItemDisplayer gameItem: item ]]
]

{ #category : #initialization }
GameCollectorModel >> initializeWidgets [
	listDisplayer := self instantiate: SpGameListPresenter.
	gameItemDisplayer := self instantiate: GameItemDisplayer.
	self focusOrder add: listDisplayer ; add: gameItemDisplayer 
]

{ #category : #accessing }
GameCollectorModel >> list [
	^ listDisplayer
]

{ #category : #accessing }
GameCollectorModel >> list: anObject [
	listDisplayer := anObject
]

{ #category : #accessing }
GameCollectorModel >> on: aGameCollector [
	gameCollector := aGameCollector.
	listDisplayer on: aGameCollector.
]
