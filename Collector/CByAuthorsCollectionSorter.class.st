Class {
	#name : #CByAuthorsCollectionSorter,
	#superclass : #CCollectionSorter,
	#category : #'Collector-Core'
}

{ #category : #sorting }
CByAuthorsCollectionSorter >> sort: items [ 
	| dict | 
	dict := (items groupedBy: [:each | each authors]).
		self halt.
	^ dict keys flattened sorted: [ :a :b | a name < b name ] 
]
