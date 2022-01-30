"
I should be reexpressed as a visitor.
"
Class {
	#name : #CDCompactBookPrinter,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'Collector-SimpleBooks-Operations'
}

{ #category : #accessing }
CDCompactBookPrinter >> contents [
	^ stream contents
]

{ #category : #accessing }
CDCompactBookPrinter >> newLine [

	^ self stream nextPutAll: self newLineEncoding 
]

{ #category : #accessing }
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
	
	self printAuthor: aBook authors first.
	self stream space.
	aBook serie printOn: self stream.
	self stream nextPut: $: ; space.
	self stream nextPutAll: aBook title.
	aBook number ifNotNil: [ self stream 
											nextPutAll: ' (n:'; nextPutAll: aBook number asString; nextPut: $) ]  
]

{ #category : #author }
CDCompactBookPrinter >> printCollection: aCollection [ 
	
	aCollection sortedItems do: [ :entry | self printBook: entry ] separatedBy: [ self newLine ]
]

{ #category : #author }
CDCompactBookPrinter >> printSerie: aSerie [ 
	
	aSerie items do: [ :each | self printBook: each ] separatedBy: [ self newLine ]
]

{ #category : #author }
CDCompactBookPrinter >> printSeriesOfAuthor: aCBookAuthor [ 
	
	aCBookAuthor series do: [ :serie | self printSerie: serie ] separatedBy: [ self newLine ].
	self newLine
]

{ #category : #accessing }
CDCompactBookPrinter >> setStream: aStream [

	stream := aStream
]

{ #category : #accessing }
CDCompactBookPrinter >> stream [

	^ stream ifNil: [ stream := WriteStream on: '' ]
]
