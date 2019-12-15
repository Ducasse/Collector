Class {
	#name : #CBookAuthor,
	#superclass : #CObject,
	#instVars : [
		'books',
		'firstName',
		'name'
	],
	#category : #'Collector-SimpleBooks'
}

{ #category : #visiting }
CBookAuthor >> accept: aVisitor [

	aVisitor visitAuthor: self
]

{ #category : #adding }
CBookAuthor >> addBook: aBook [

	books add: aBook
]

{ #category : #accessing }
CBookAuthor >> books [
	^ books
]

{ #category : #accessing }
CBookAuthor >> books: anObject [
	books := anObject
]

{ #category : #accessing }
CBookAuthor >> firstName [
	^ firstName
]

{ #category : #accessing }
CBookAuthor >> firstName: anObject [
	firstName := anObject
]

{ #category : #initialization }
CBookAuthor >> initialize [ 	

	super initialize.
	books := OrderedCollection  new.
	firstName := ''
]

{ #category : #accessing }
CBookAuthor >> name [
	^ name
]

{ #category : #accessing }
CBookAuthor >> name: anObject [
	name := anObject
]

{ #category : #printing }
CBookAuthor >> printOn: aStream [

	aStream << name.
	firstName ifNotNil: [ :fstName | aStream << ', ' << fstName ]	
]

{ #category : #iterating }
CBookAuthor >> series [
	| series |
	"we should probably change this in the future by sotring authors instead of books but for now set is not a good idea to 
	remove duplicated entries when computing series since the order is changing."
	series := OrderedCollection new. 
	self books do: [ :eachBook | (series includes: eachBook serie) ifFalse: [series add: eachBook serie ]].
	^ series
]
