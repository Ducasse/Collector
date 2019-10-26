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
		'gamesListPresenter',
		'gameDisplayer'
	],
	#category : #'Collector-UI'
}

{ #category : #accessing }
SpItemListPresenter class >> collection: aCollectionOfGames [
	^ self new
		collection: aCollectionOfGames;
		yourself
]

{ #category : #specs }
SpItemListPresenter class >> defaultSpec [
	^ SpPanedLayout newHorizontal
		position: 30 percent;
		add: #gamesListPresenter;
		add: #gameDisplayer;
		yourself
]

{ #category : #'instance creation' }
SpItemListPresenter class >> open [
	<script>
	(self collection: (CCollector smallCollection2 collectionNamed: #owned)) openWithSpec
]

{ #category : #accessing }
SpItemListPresenter >> collection: aCollectionOfGames [
	self gamesListPresenter
		items: aCollectionOfGames;
		selectIndex: 1
]

{ #category : #accessing }
SpItemListPresenter >> gamesListPresenter [ 
	^ gamesListPresenter
]

{ #category : #initialization }
SpItemListPresenter >> initializePresenter [
	super initializePresenter.
	self gamesListPresenter
		whenSelectionChangedDo: [ :selection | 
			gameDisplayer gameItem: selection selectedItem.
			self withWindowDo: [ :w | w title: self title ] ]
]

{ #category : #initialization }
SpItemListPresenter >> initializeWidgets [
	gamesListPresenter := self newList.
	gameDisplayer := self instantiate: SpItemDisplayerPresenter.
	gamesListPresenter
		display: [ :item | item title , ' - ' , item console ];
		sortingBlock: [ :cls1 :cls2 | cls1 title < cls2 title ];
		enableItemSubstringFilter
]

{ #category : #initialization }
SpItemListPresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter
		title: self title;
		initialExtent: 600 @ 500
]

{ #category : #accessing }
SpItemListPresenter >> selectedGame [
	^ self gamesListPresenter selectedItem
]

{ #category : #initialization }
SpItemListPresenter >> title [
	^ 'List of Games ' , (self selectedGame ifNotNil: [ :game | ' - ' , game title ] ifNil: [ '' ])
]

{ #category : #initialization }
SpItemListPresenter >> whenSelectedItemChanged: aBlock [
  	gamesListPresenter whenSelectedItemChanged: aBlock
]
