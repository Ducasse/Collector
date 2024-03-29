"
I'm a collection of items and I support such collection. 
My items can be item or groups of items. 
"
Class {
	#name : #CCollection,
	#superclass : #CObject,
	#instVars : [
		'items',
		'sorter',
		'name'
	],
	#category : #'Collector-Core'
}

{ #category : #'instance creation' }
CCollection class >> newWith: aString [

	^ self new name: aString ; yourself
]

{ #category : #visiting }
CCollection >> accept: aVisitor [

	aVisitor visitCollection: self
]

{ #category : #adding }
CCollection >> add: aCBookItem [ 
	
	items add: aCBookItem.
	^ aCBookItem 
]

{ #category : #initialization }
CCollection >> anyOne [

	^ items anyOne
]

{ #category : #'in/out' }
CCollection >> asSTON [
	^ String streamContents: [ :s | self asSTON: s ]
]

{ #category : #'in/out' }
CCollection >> asSTON: aStream [
	^  STON put: self onStreamPretty: aStream
]

{ #category : #'collection api' }
CCollection >> at: index [ 
	
	^ items at: index
]

{ #category : #'collection api' }
CCollection >> at: index ifAbsent: aBlock [ 
	
	^ items at: index ifAbsent: aBlock 
]

{ #category : #accessing }
CCollection >> children [ 
	^ items
]

{ #category : #'collection api' }
CCollection >> includes: anItem [

	^ items includes: anItem
]

{ #category : #initialization }
CCollection >> initialize [ 
	super initialize. 
	self items: OrderedCollection new. 
	self sorter: CCollectionSorter new
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

{ #category : #printing }
CCollection >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: ' #', items size printString
]

{ #category : #'collection api' }
CCollection >> remove: anItem [

	items remove: anItem
]

{ #category : #'collection api' }
CCollection >> remove: anItem ifAbsent: aBlock [

	items remove: anItem ifAbsent: aBlock
]

{ #category : #'collection api' }
CCollection >> select: aBlock [

	^ items select: aBlock
]

{ #category : #accessing }
CCollection >> size [ 
	^ items size
]

{ #category : #sorting }
CCollection >> sorted [ 

	^ self sorter sort: self items
]

{ #category : #sorting }
CCollection >> sorted: aBlock [

	^ self sorter sort: items
]

{ #category : #sorting }
CCollection >> sortedItems [

	^ self sorter sort: self items
]

{ #category : #sorting }
CCollection >> sortedItemsWithBlock: aBlock [

	^ self sorter sort: items
]

{ #category : #accessing }
CCollection >> sorter [
	^ sorter
]

{ #category : #accessing }
CCollection >> sorter: anObject [
	sorter := anObject
]
