Class {
	#name : #CMapperTest,
	#superclass : #TestCase,
	#category : #'Collector-Easy'
}

{ #category : #tests }
CMapperTest >> testPriceConversion [

	| map |
	map := CMapper new.
	map convert: 'price' using: [:each | each asNumber].
	
	self assert: (map convert: 'price' value: '2.39') equals: 2.39
]

{ #category : #tests }
CMapperTest >> testTitleSelector [

	| map |
	map := CMapper new.
	map selectorFor: 'title' is: #title.
	
	self assert: (map selectorFor: 'title')  equals: #title
]
