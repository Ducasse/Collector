Class {
	#name : #CDCompactBookPrinter,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'Collector-SimpleBooks'
}

{ #category : #accessing }
CDCompactBookPrinter >> contents [
	^ stream contents
]

{ #category : #author }
CDCompactBookPrinter >> printAuthorName: aCBookAuthor [ 
	
	self stream 
		nextPut: aCBookAuthor firstName first;
		space;
		nextPutAll: aCBookAuthor name
		
]

{ #category : #author }
CDCompactBookPrinter >> setStream: aStream [

	stream := aStream
]

{ #category : #author }
CDCompactBookPrinter >> stream [

	^ stream ifNil: [ stream := WriteStream on: '' ]
]
