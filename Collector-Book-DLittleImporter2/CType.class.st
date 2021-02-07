Class {
	#name : #CType,
	#superclass : #CObject,
	#instVars : [
		'type'
	],
	#category : #'Collector-Book-DLittleImporter2'
}

{ #category : #'instance creation' }
CType class >> newWith: aType [

	^ self new type: aType ; yourself
]

{ #category : #asserting }
CType >> shouldConvert [ 
	^ false
]

{ #category : #accessing }
CType >> type: aString [ 
	type := aString
]
