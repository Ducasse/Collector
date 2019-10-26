Class {
	#name : #CBookItem,
	#superclass : #Object,
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
		'number'
	],
	#category : #'Collector-Core'
}

{ #category : #converrting }
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
CBookItem >> links [
	^ links
]

{ #category : #accessing }
CBookItem >> links: anObject [
	links := anObject
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
CBookItem >> price [
	^ price
]

{ #category : #accessing }
CBookItem >> price: anObject [
	price := anObject
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
