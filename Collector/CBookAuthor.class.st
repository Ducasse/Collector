Class {
	#name : #CBookAuthor,
	#superclass : #Object,
	#instVars : [
		'books',
		'firstName',
		'name'
	],
	#category : #'Collector-SimpleBooks'
}

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
