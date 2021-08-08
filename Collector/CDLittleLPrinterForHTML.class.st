Class {
	#name : #CDLittleLPrinterForHTML,
	#superclass : #CDLittleLPrinter,
	#category : #'Collector-SimpleBooks'
}

{ #category : #visiting }
CDLittleLPrinterForHTML >> visitCollection: aCollection [
	
	aCollection sorter: CByAuthorsCollectionSorter new.
	stream << '<pre>'.
	super visitCollection: aCollection.
	stream << '</pre>'.
]
