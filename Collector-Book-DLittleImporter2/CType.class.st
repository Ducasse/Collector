Class {
	#name : #CType,
	#superclass : #CObject,
	#instVars : [
		'type'
	],
	#category : #'Collector-Book-DLittleImporter2-Core'
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
CType >> type [
	"We will remove it once I will integrate the optional part of ilyas"
	
	^type
]

{ #category : #accessing }
CType >> type: aString [ 
	"We will remove it once I will integrate the optional part of ilyas"
	
	^type
]
