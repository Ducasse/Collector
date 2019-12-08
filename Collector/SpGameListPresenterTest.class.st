Class {
	#name : #SpGameListPresenterTest,
	#superclass : #TestCase,
	#category : #'Collector-Tests-UI'
}

{ #category : #tests }
SpGameListPresenterTest >> testOpen [
	| gameList |
	gameList := SpItemListPresenter new collection: (CGameCollector smallCollection collectionNamed: #owned).
	self assert: gameList gamesListPresenter selectedItems size equals: 1
]
