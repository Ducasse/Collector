Class {
	#name : #CAlias,
	#superclass : #CObject,
	#instVars : [
		'alias'
	],
	#category : #'Collector-Book-DLittleImporter2-Core'
}

{ #category : #'instance creation' }
CAlias class >> newWith: anAlias [

	^ self new alias: anAlias ; yourself
]

{ #category : #accessing }
CAlias >> alias [
	"We will remove it once I will integrate the optional part of ilyas"
	
	^alias
]

{ #category : #accessing }
CAlias >> alias: aString [ 
	"We will remove it once I will integrate the optional part of ilyas"
	
	alias := aString
]
