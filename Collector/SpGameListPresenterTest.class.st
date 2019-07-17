Class {
	#name : #SpGameListPresenterTest,
	#superclass : #TestCase,
	#category : #'Collector-Tests'
}

{ #category : #tests }
SpGameListPresenterTest >> testOpen [

	| gameList |
	gameList := SpGameListPresenter new on: GameCollector smallCollection.
	self assert: gameList listModel selectedItems isEmpty
]
