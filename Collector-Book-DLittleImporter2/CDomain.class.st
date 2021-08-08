Class {
	#name : #CDomain,
	#superclass : #CObject,
	#instVars : [
		'domain'
	],
	#category : #'Collector-Book-DLittleImporter2'
}

{ #category : #'instance creation' }
CDomain class >> newWith: aDomain [

	^ self new domain: aDomain ; yourself
]

{ #category : #accessing }
CDomain >> domain [
	"We will remove it once I will integrate the optional part of ilyas"
	
	^domain
]

{ #category : #accessing }
CDomain >> domain: aString [ 
	"We will remove it once I will integrate the optional part of ilyas"
	
	domain := aString
]
