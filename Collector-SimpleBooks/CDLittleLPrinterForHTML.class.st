"
I'm a rather super ugly and limited HTML printer
"
Class {
	#name : #CDLittleLPrinterForHTML,
	#superclass : #CDLittleLPrinter,
	#category : #'Collector-SimpleBooks-Operations'
}

{ #category : #visiting }
CDLittleLPrinterForHTML >> visitCollection: aCollection [
	
	aCollection sorter: CByAuthorsCollectionSorter new.
	stream << '<pre>'.
	super visitCollection: aCollection.
	stream << '</pre>'.
]
