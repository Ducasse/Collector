"
I'm a kind of collection and I know if I'm complete or not.
This behavior may make more sense in the superclass. 
So we should reevaluate it. 
"
Class {
	#name : #CBookSerie,
	#superclass : #CCollection,
	#instVars : [
		'complete',
		'numberOfBooks',
		'finished'
	],
	#category : #'Collector-SimpleBooks-Domain'
}

{ #category : #'instance creation' }
CBookSerie class >> newWith: aName [
	^ self new 
		name: aName; 
		yourself
]

{ #category : #visiting }
CBookSerie >> accept: aVisitor [

	aVisitor visitSerie: self
]

{ #category : #printing }
CBookSerie >> add: aBook [
	
	items add: aBook
]

{ #category : #printing }
CBookSerie >> books [ 
	
	^ items
]

{ #category : #printing }
CBookSerie >> children [ 
	^ items
]

{ #category : #accessing }
CBookSerie >> complete [
	^ complete
]

{ #category : #accessing }
CBookSerie >> complete: anObject [
	complete := anObject
]

{ #category : #accessing }
CBookSerie >> finished [
	^ finished
]

{ #category : #accessing }
CBookSerie >> finished: aBoolean [
	finished := aBoolean
]

{ #category : #printing }
CBookSerie >> numberOfBooks [
	
	^ numberOfBooks
]

{ #category : #printing }
CBookSerie >> numberOfBooks: aNumber [
	
	numberOfBooks := aNumber
]

{ #category : #printing }
CBookSerie >> printOn: aStream [

	aStream << 'S-'.
	aStream << name.

]
