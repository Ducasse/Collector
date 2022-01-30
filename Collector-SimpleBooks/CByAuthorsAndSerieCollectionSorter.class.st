Class {
	#name : #CByAuthorsAndSerieCollectionSorter,
	#superclass : #CCollectionSorter,
	#category : #'Collector-SimpleBooks-Domain'
}

{ #category : #sorting }
CByAuthorsAndSerieCollectionSorter >> sort: items [ 
	| dictAuthor | 
	self halt.
	dictAuthor := (items groupedBy: [:each | each authors]).
	^ dictAuthor keys flattened sorted: [ :a :b | a name < b name ] 
]
