Class {
	#name : #CBkCollectorDLittleImporter2Test,
	#superclass : #TestCase,
	#instVars : [
		'importer'
	],
	#category : #'Collector-Book-DLittleImporter2'
}

{ #category : #accessing }
CBkCollectorDLittleImporter2Test >> importer [
	^ CBkCollectorDLittleImporter2 new
]

{ #category : #accessing }
CBkCollectorDLittleImporter2Test >> setUp [ 
	super setUp.
	importer := self importer. 

]

{ #category : #accessing }
CBkCollectorDLittleImporter2Test >> testExtractBasicBook [
	| book |
	book := importer
		bookFrom:
			(DLittleLParser
				parse:
					'(title : Les vents du changement)').
					
	self assert: book title equals: 'Les vents du changement'.

]

{ #category : #accessing }
CBkCollectorDLittleImporter2Test >> testExtractBook [
	| book |
	book := importer
		bookFrom:
			(DLittleLParser
				parse:
					'(title : Les vents du changement (read : no) (style : SF) (price : 2.39))').
					
	self assert: book title equals: 'Les vents du changement'.
	self assert: book price equals: 2.39.
	self assert: book style equals: 'SF'.
	self deny: book read

]

{ #category : #accessing }
CBkCollectorDLittleImporter2Test >> testExtractBookKeepExtraInformation [
	| book |
	book := importer
		bookFrom:
			(DLittleLParser
				parse:
					'(title : Les vents du changement (read : no) (style : SF) (price : 2.39) (ffo : this is an imporant information))').
					
	self assert: (book propertyAt: 'ffo') equals: 'this is an imporant information'

]
