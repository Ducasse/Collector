Class {
	#name : #CBkCollectionPresenter,
	#superclass : #SpPresenter,
	#traits : 'SpTModel',
	#classTraits : 'SpTModel classTrait',
	#instVars : [
		'tree',
		'detail',
		'toolbar',
		'collection'
	],
	#category : #'Collector-BookUI'
}

{ #category : #accessing }
CBkCollectionPresenter >> collection [ 

	^ collection ifNil: [  ]
]

{ #category : #initialization }
CBkCollectionPresenter >> initializePresenters [ 

	self layout: (SpBoxLayout newLeftToRight
		add: (tree := self newTree);
		add: (detail := self newPresenter);
		yourself).
		
	tree 
		display: [ :aNode | aNode name ];
		children: [ :aNode | aNode children ].

	tree transmitDo: [ :aNode |
		| newPresenter |
		newPresenter := CBkDetailPresenter on: aNode.
		self layout 
			replace: detail 
			with: newPresenter.
		detail := newPresenter ]
]

{ #category : #initialization }
CBkCollectionPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: 'My Collections'
]

{ #category : #accessing }
CBkCollectionPresenter >> start [

	(CBkCollectionPresenter 
		newApplication: self 
		model: self collection)
		open
]

{ #category : #initialization }
CBkCollectionPresenter >> toolbar [

	^ toolbar ifNil: [ 
		toolbar := self newToolbar
			add: (self newToolbarButton 
				icon: (self iconNamed: #paint);
				label: 'Stats';
				action: [ self doShowStatistics ];
				yourself);
			yourself ]
]

{ #category : #initialization }
CBkCollectionPresenter >> updatePresenter [

	tree roots: { self model }
]
