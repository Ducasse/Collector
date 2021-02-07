Class {
	#name : #CImporterConfiguration,
	#superclass : #CObject,
	#instVars : [
		'types'
	],
	#category : #'Collector-Book-DLittleImporter2'
}

{ #category : #adding }
CImporterConfiguration >> add: anElement [

	types add: anElement
]

{ #category : #initialization }
CImporterConfiguration >> initialize [ 
	super initialize.
	types := OrderedCollection new
]
