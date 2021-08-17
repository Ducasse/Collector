Class {
	#name : #CDCompactBookPrinter,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'Collector-SimpleBook-Tests'
}

{ #category : #accessing }
CDCompactBookPrinter >> contents [
	^ stream contents
]

{ #category : #author }
CDCompactBookPrinter >> newLine [

	^ self stream nextPutAll: self newLineEncoding 
]

{ #category : #author }
CDCompactBookPrinter >> newLineEncoding [

	^ String lf
]

{ #category : #author }
CDCompactBookPrinter >> printAuthor: aCBookAuthor [ 
	
	aCBookAuthor firstName 
		ifNotEmpty: [ 
				self stream 
					nextPut: aCBookAuthor firstName first ; 
					space ].
	self stream
		nextPutAll: aCBookAuthor name
		
]

{ #category : #author }
CDCompactBookPrinter >> printBook: aBook [ 
	
	aBook serie printOn: self stream.
	self stream nextPut: $: ; space.
	self stream nextPutAll: aBook title.
	aBook number ifNotNil: [ self stream nextPutAll: ' (n:'; print: aBook number; nextPut: $) ]  
]

{ #category : #author }
CDCompactBookPrinter >> printSerie: aSerie [ 
	
	aSerie items do: [ :each | self printBook: each ] separatedBy: [ self newLine ]
]

{ #category : #author }
CDCompactBookPrinter >> setStream: aStream [

	stream := aStream
]

{ #category : #author }
CDCompactBookPrinter >> stream [

	^ stream ifNil: [ stream := WriteStream on: '' ]
]
