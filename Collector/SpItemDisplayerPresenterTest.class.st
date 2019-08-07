Class {
	#name : #SpItemDisplayerPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'itemDisplayer'
	],
	#category : #'Collector-Tests-UI'
}

{ #category : #running }
SpItemDisplayerPresenterTest >> setUp [
	super setUp.
	itemDisplayer := SpItemDisplayerPresenter new
		gameItem: GameItem finalFantasyX;
		openWithSpec;
		yourself.
]

{ #category : #running }
SpItemDisplayerPresenterTest >> tearDown [
	itemDisplayer withWindowDo: #close.
	super tearDown
]

{ #category : #tests }
SpItemDisplayerPresenterTest >> testInformationsAreUpdatedWhenGameItemChanges [
	self assert: itemDisplayer quotationNumberModel number equals: GameItem finalFantasyX quotation.
	self assert: itemDisplayer hasDocCheckBoxModel state equals: GameItem finalFantasyX hasDocumentation.

	itemDisplayer gameItem: GameItem finalFantasyX2.

	self assert: itemDisplayer quotationNumberModel number equals: GameItem finalFantasyX2 quotation.
	self assert: itemDisplayer hasDocCheckBoxModel state equals: GameItem finalFantasyX2 hasDocumentation
]
