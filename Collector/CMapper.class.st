"
I map 
	strings to pharo internal types.
 	key to instance variables.
"
Class {
	#name : #CMapper,
	#superclass : #Object,
	#instVars : [
		'selectorMap',
		'convertor'
	],
	#category : #'Collector-Importer'
}

{ #category : #conversion }
CMapper >> convert: aString using: aBlockClosure [ 
	convertor at: aString put: aBlockClosure
]

{ #category : #conversion }
CMapper >> convert: aString value: aString2 [ 
	^ (convertor at: aString ifAbsent: [ [:each2 | each2 ] ]) value: aString2
]

{ #category : #'selector protocols' }
CMapper >> initialize [

	super initialize. 
	selectorMap := Dictionary new. 
	convertor := Dictionary new.
]

{ #category : #'selector protocols' }
CMapper >> selectorFor: aString [
	^ selectorMap at: aString ifAbsent: [ aString asSymbol ]
]

{ #category : #'selector protocols' }
CMapper >> selectorFor: aString is: aString2 [ 
	selectorMap at: aString put: aString2
]
