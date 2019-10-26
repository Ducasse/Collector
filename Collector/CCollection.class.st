Class {
	#name : #CCollection,
	#superclass : #Object,
	#instVars : [
		'tag',
		'items',
		'sorter'
	],
	#category : #'Collector-Core'
}

{ #category : #adding }
CCollection >> add: aCBookItem [ 
	items add: aCBookItem.
	^ aCBookItem 
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

{ #category : #accessing }
CCollection >> tag [
	^ tag
]

{ #category : #accessing }
CCollection >> tag: anObject [
	tag := anObject
]
