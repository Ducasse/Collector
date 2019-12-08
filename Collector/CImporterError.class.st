Class {
	#name : #CImporterError,
	#superclass : #Exception,
	#category : #'Collector-Importer'
}

{ #category : #accessing }
CImporterError >> defaultAction [ 
	
	UIManager default notify: messageText
]
