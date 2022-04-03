"
CBkApplication new run
"
Class {
	#name : #CBkApplication,
	#superclass : #SpApplication,
	#instVars : [
		'collection'
	],
	#category : #'Collector-BookUI'
}

{ #category : #accessing }
CBkApplication >> collection [ 

	^ collection ifNil: [ CCollectorDLittleImporter2 new importFromString: CBkCollectorDLittleImporterTest minilist]
]

{ #category : #accessing }
CBkApplication >> start [ 

	(CBkCollectionPresenter 
		newApplication: self 
		model: self collection)
		open
]
