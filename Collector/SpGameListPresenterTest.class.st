Class {
	#name : #SpGameListPresenterTest,
	#superclass : #TestCase,
	#category : #'Collector-Tests'
}

{ #category : #tests }
SpGameListPresenterTest >> testOpen [

	| gameList |
	gameList := SpItemListPresenter new on: (GameCollector smallCollection collectionNamed: #owned).
	self assert: gameList listModel selectedItems isEmpty
]
