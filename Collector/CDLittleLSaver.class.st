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

{ #category : #initialization }
CDLittleLSaver >> save: aCollection inFileNamed: aName [
	"self new save: YCOll  inFileNamed: '/Users/ducasse/Workspace/FirstCircle/Working/SF/sf/books.dl'"
	| printer fileref stream |
	fileref := aName asFileReference.
	fileref exists 	
		ifTrue: [ 
				| oldFileRef |
				oldFileRef := fileref parent / ('Old-', fileref basename).
				oldFileRef exists ifTrue: [ oldFileRef delete ].  
				fileref renameTo: 'Old-', fileref basename.
				fileref := aName asFileReference ].	
				
	[ stream := fileref writeStream. 
	printer := CDLittleLPrinter new.
	printer stream: stream. 
	printer print: aCollection. ]
	ensure: [ stream close ]. 
	
	[ CCollectorDLittleImporter new importFromFileName: aName]
		on: Error do: [ :ex | Stdio stdout << 'There is an error close to ...' ]
	
	
	
]
