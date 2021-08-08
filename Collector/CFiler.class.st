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
	#instVars : [
		'importer'
	],
	#category : #'Collector-Utils'
}

{ #category : #copying }
CFiler >> books [ 
	
	| printer |
	printer := CDLittleLPrinter new. 
 	printer print: importer importedCollection.
	^ printer contents
	
]

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

	importer := (CBkCollectorDLittleImporter new importFromFileName:  self workingFile)
]

{ #category : #copying }
CFiler >> rawBooks [ 
	^ importer importedCollection items
]

{ #category : #copying }
CFiler >> stonishBooks [ 
	
	^ STON toStringPretty: importer importedCollection items  
	
]

{ #category : #copying }
CFiler >> uglyAuthors [
	
	| printer |
	printer := CDLittleLPrinter new. 
 	printer print: importer importedCollection.
	^ printer contents
]

{ #category : #copying }
CFiler >> workingFile [

	^ FileSystem workingDirectory / 'books.dl'
]
