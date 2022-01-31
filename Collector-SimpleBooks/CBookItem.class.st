Class {
	#name : #CBookItem,
	#superclass : #CObject,
	#instVars : [
		'read',
		'summary',
		'links',
		'condition',
		'comments',
		'price',
		'title',
		'authors',
		'serie',
		'number',
		'style',
		'format',
		'part',
		'originalTitle',
		'year'
	],
	#category : #'Collector-SimpleBooks-Domain'
}

{ #category : #'instance creation' }
CBookItem class >> newWith: aTitle [
	
	^ self new title: aTitle ; yourself
]

{ #category : #visiting }
CBookItem >> accept: aVisitor [

	aVisitor visitBook: self
]

{ #category : #adding }
CBookItem >> addAuthor: anAuthor [
	authors add: anAuthor.
	anAuthor addBook: self
]

{ #category : #converting }
CBookItem >> asSTON [
	^ STON toStringPretty: self
]

{ #category : #accessing }
CBookItem >> authors [
	^ authors
]

{ #category : #accessing }
CBookItem >> authors: anObject [
	authors := anObject
]

{ #category : #accessing }
CBookItem >> comments [
	^ comments
]

{ #category : #accessing }
CBookItem >> comments: anObject [
	comments := anObject
]

{ #category : #accessing }
CBookItem >> condition [
	^ condition
]

{ #category : #accessing }
CBookItem >> condition: anObject [
	condition := anObject
]

{ #category : #accessing }
CBookItem >> didRead [
	read := true
]

{ #category : #accessing }
CBookItem >> format [
	^ format
]

{ #category : #accessing }
CBookItem >> format: anObject [
	format := anObject
]

{ #category : #initialization }
CBookItem >> initialize [ 
	super initialize.
	authors := OrderedCollection new.
	title := 'notitle'
]

{ #category : #accessing }
CBookItem >> links [
	^ links
]

{ #category : #accessing }
CBookItem >> links: anObject [
	links := anObject
]

{ #category : #accessing }
CBookItem >> mainAuthor [

	^ self authors first
]

{ #category : #accessing }
CBookItem >> notRead [
	read := false
]

{ #category : #accessing }
CBookItem >> number [
	^ number
]

{ #category : #accessing }
CBookItem >> number: anObject [
	number := anObject
]

{ #category : #accessing }
CBookItem >> originalTitle [
	^ originalTitle
]

{ #category : #accessing }
CBookItem >> originalTitle: anObject [
	originalTitle := anObject
]

{ #category : #accessing }
CBookItem >> part [
	^ part
]

{ #category : #accessing }
CBookItem >> part: anObject [
	part := anObject
]

{ #category : #accessing }
CBookItem >> price [
	^ price
]

{ #category : #accessing }
CBookItem >> price: anObject [
	price := anObject
]

{ #category : #printing }
CBookItem >> printOn: aStream [

	aStream << 'B-'.
	aStream << self title 
]

{ #category : #accessing }
CBookItem >> read [
	^ read
]

{ #category : #accessing }
CBookItem >> read: anObject [
	read := anObject
]

{ #category : #accessing }
CBookItem >> serie [
	^ serie
]

{ #category : #accessing }
CBookItem >> serie: anObject [
	serie := anObject
]

{ #category : #accessing }
CBookItem >> style [
	^ style
]

{ #category : #accessing }
CBookItem >> style: anObject [
	style := anObject
]

{ #category : #accessing }
CBookItem >> summary [
	^ summary
]

{ #category : #accessing }
CBookItem >> summary: anObject [
	summary := anObject
]

{ #category : #accessing }
CBookItem >> title [
	^ title
]

{ #category : #accessing }
CBookItem >> title: anObject [
	title := anObject
]

{ #category : #accessing }
CBookItem >> year [
	^ year
]

{ #category : #accessing }
CBookItem >> year: anObject [
	year := anObject
]
