"
I'm a simple object collecting utils to manage files....
Nothing exciting.

Basic logic is

```
	self new copyToLocal; loadFileInMemory
```
"
Class {
	#name : #CFiler,
	#superclass : #Object,
	#category : #'Collector-Utils'
}

{ #category : #copying }
CFiler >> copyToLocal [
	"
	self new copyToLocal
	"
	self workingFile ensureDelete.
	'/Users/ducasse/Workspace/FirstCircle/Working/SF/sf/books.dl' asFileReference 
		copyTo: self workingFile
]

{ #category : #copying }
CFiler >> loadFileInMemory [

	(CBkCollectorDLittleImporter new importFromFileName:  self workingFile)
]

{ #category : #copying }
CFiler >> workingFile [

	^ FileSystem workingDirectory / 'books.dl'
]
