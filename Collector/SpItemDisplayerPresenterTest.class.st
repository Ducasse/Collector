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
		gameItem: CGameItem finalFantasyX;
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
	self assert: itemDisplayer quotationNumberModel number equals: CGameItem finalFantasyX quotation.
	self assert: itemDisplayer hasDocCheckBoxModel state equals: CGameItem finalFantasyX hasDocumentation.

	itemDisplayer gameItem: CGameItem finalFantasyX2.

	self assert: itemDisplayer quotationNumberModel number equals: CGameItem finalFantasyX2 quotation.
	self assert: itemDisplayer hasDocCheckBoxModel state equals: CGameItem finalFantasyX2 hasDocumentation
]
