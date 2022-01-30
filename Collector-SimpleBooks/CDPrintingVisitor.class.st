Class {
	#name : #CDPrintingVisitor,
	#superclass : #CSimpleBookVisitor,
	#instVars : [
		'stream',
		'tabs'
	],
	#category : #'Collector-SimpleBooks-Operations'
}

{ #category : #visiting }
CDPrintingVisitor >> contents [ 
	^ stream contents
]

{ #category : #visiting }
CDPrintingVisitor >> decreaseTabs [

	tabs := tabs - 1
]

{ #category : #visiting }
CDPrintingVisitor >> emitTabs [

	tabs timesRepeat: [ stream tab ]
]

{ #category : #visiting }
CDPrintingVisitor >> increaseTabs [

	tabs := tabs + 1
]

{ #category : #initialization }
CDPrintingVisitor >> initialize [ 
	super initialize.
	stream := WriteStream on: ''.
	tabs := 0
]

{ #category : #visiting }
CDPrintingVisitor >> newline [
	stream lf
]

{ #category : #accessing }
CDPrintingVisitor >> stream: aStream [

	stream := aStream
]
