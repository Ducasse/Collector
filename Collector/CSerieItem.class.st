"
I'm a kind of collection and I know if I'm complete or not.
This behavior may make more sense in the superclass. 
So we should reevaluate it. 
"
Class {
	#name : #CSerieItem,
	#superclass : #CCollection,
	#instVars : [
		'complete'
	],
	#category : #'Collector-SimpleBooks'
}

{ #category : #accessing }
CSerieItem >> complete [
	^ complete
]

{ #category : #accessing }
CSerieItem >> complete: anObject [
	complete := anObject
]
