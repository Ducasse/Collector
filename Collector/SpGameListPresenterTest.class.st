Class {
	#name : #SpGameListPresenterTest,
	#superclass : #TestCase,
	#category : #'Collector-Tests'
}

{ #category : #tests }
SpGameListPresenterTest >> testOpen [
	| gameList |
	gameList := SpItemListPresenter new on: (CCollector smallCollection collectionNamed: #owned).
	self assertEmpty: gameList gamesListPresenter selectedItems
]
