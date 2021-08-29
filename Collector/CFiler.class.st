"
I'm a simple object collecting utils to manage files....
Nothing exciting.

Basic logic is

```
	self new 
		fileDBPath: '/Users/ducasse/Workspace/FirstCircle/Working/SF/sf/books.dl';
		copyToLocal; 
		loadFileInMemory
```
"
Class {
	#name : #CFiler,
	#superclass : #Object,
	#instVars : [
		'importer',
		'fileDBPath'
	],
	#category : #'Collector-Utils'
}

{ #category : #outputs }
CFiler >> books [ 
	
	^ self uglyAuthors
]

{ #category : #outputs }
CFiler >> booksAsText [
	
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
	self fileDBPath asFileReference 
		copyTo: self workingFile
]

{ #category : #accessing }
CFiler >> fileDBPath [

	^ fileDBPath 
	
]

{ #category : #accessing }
CFiler >> fileDBPath: aPathString [

	fileDBPath := aPathString 
	
]

{ #category : #outputs }
CFiler >> fullBooksAsText [ 
	
	| printer |
	printer := CDLittleLPrinter new. 
 	printer print: importer importedCollection.
	^ printer contents
	
]

{ #category : #initialization }
CFiler >> initialize [ 
	super initialize.
	self fileDBPath: '/Users/ducasse/Workspace/FirstCircle/Working/SF/sf/books.dl' asFileReference
]

{ #category : #copying }
CFiler >> loadFileInMemory [

	importer := (CBkCollectorDLittleImporter new importFromFileName:  self workingFile)
]

{ #category : #copying }
CFiler >> rawBooks [ 
	^ importer importedCollection items
]

{ #category : #outputs }
CFiler >> stonishBooks [ 
	
	^ STON toStringPretty: importer importedCollection items  
	
]

{ #category : #outputs }
CFiler >> uglyAuthors [
	
	| printer |
	printer := CDCompactBookPrinter new. 
 	printer printCollection: importer importedCollection.
	^ printer contents
]

{ #category : #accessing }
CFiler >> workingFile [

	^ FileSystem workingDirectory / 'books.dl'
]
