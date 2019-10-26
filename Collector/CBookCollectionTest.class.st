Class {
	#name : #CBookCollectionTest,
	#superclass : #TestCase,
	#category : #'Collector-Tests'
}

{ #category : #tests }
CBookCollectionTest >> testSorted [ 

	| c s |
	c := CBookCollector smallCollection.
	self assert: c size equals: 4.
	
	"when we sort book we do not get anymore all the books in on row but the authors."
	s := c sorted. 
	self assert: s size equals: 2.
	self assert: s first name equals: 'Adam'.
	self assert: s last name equals: 'Wilson'.
	
	self assert: s first books size equals: 3
]
