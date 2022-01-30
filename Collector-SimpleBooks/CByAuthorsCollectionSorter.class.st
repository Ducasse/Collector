Class {
	#name : #CByAuthorsCollectionSorter,
	#superclass : #CCollectionSorter,
	#category : #'Collector-SimpleBooks-Domain'
}

{ #category : #sorting }
CByAuthorsCollectionSorter >> sort: items [ 
	| dict | 
	dict := (items groupedBy: [:each | each authors]).
	^ dict keys flattened sorted: [ :a :b | a name < b name ] 
]
