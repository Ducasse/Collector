Class {
	#name : #CBookCollectorTest,
	#superclass : #TestCase,
	#category : #'Collector-Tests'
}

{ #category : #tests }
CBookCollectorTest >> testLoadingSTON [

	| collector |
	collector := STON fromString: (CBookCollector smallCollector asSTON).
	self assert: (collector collectionNamed: #owned) size equals: 4
]