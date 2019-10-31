Class {
	#name : #CImporterError,
	#superclass : #Exception,
	#category : #'Collector-Easy-Importer'
}

{ #category : #accessing }
CImporterError >> defaultAction [ 
	
	UIManager default notify: messageText
]
