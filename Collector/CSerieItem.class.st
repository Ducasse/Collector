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
