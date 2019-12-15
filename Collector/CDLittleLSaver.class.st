Class {
	#name : #CDLittleLSaver,
	#superclass : #Object,
	#instVars : [
		'fileSystem'
	],
	#category : #'Collector-SimpleBooks'
}

{ #category : #accessing }
CDLittleLSaver >> fileSystem [
	^ fileSystem
]

{ #category : #accessing }
CDLittleLSaver >> fileSystem: anObject [
	fileSystem := anObject
]

{ #category : #initialization }
CDLittleLSaver >> initialize [

	super initialize.
	self fileSystem: FileSystem workingDirectory
]
