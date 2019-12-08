Class {
	#name : #CCollection,
	#superclass : #Object,
	#instVars : [
		'items',
		'sorter',
		'name'
	],
	#category : #'Collector-Core'
}

{ #category : #adding }
CCollection >> add: aCBookItem [ 
	items add: aCBookItem.
	^ aCBookItem 
]

{ #category : #'in/out' }
CCollection >> asSTON [
	^ String streamContents: [ :s | self asSTON: s ]
]

{ #category : #'in/out' }
CCollection >> asSTON: aStream [
	^  STON put: self onStreamPretty: aStream
]

{ #category : #accessing }
CCollection >> initialize [ 
	super initialize. 
	self items: OrderedCollection new. 
]

{ #category : #accessing }
CCollection >> items [
	^ items
]

{ #category : #accessing }
CCollection >> items: anObject [
	items := anObject
]

{ #category : #accessing }
CCollection >> name [
	^ name
]

{ #category : #accessing }
CCollection >> name: anObject [
	name := anObject
]

{ #category : #accessing }
CCollection >> size [ 
	^ items size
]

{ #category : #sorting }
CCollection >> sorted [ 

	^ self sorter sort: self items
]

{ #category : #accessing }
CCollection >> sorter [
	^ sorter
]

{ #category : #accessing }
CCollection >> sorter: anObject [
	sorter := anObject
]
