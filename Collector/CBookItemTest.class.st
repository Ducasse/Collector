Class {
	#name : #CBookItemTest,
	#superclass : #TestCase,
	#category : #'Collector-Tests'
}

{ #category : #tests }
CBookItemTest >> testBackLinksBetweenSingleBooksAndAuthor [
	
	| author item1 item2 |
	author := (CBookAuthor new firstName: 'Douglas'; name: 'Adam').
	item1 := CBookItem new
		title: 'Le guide du voyageur inter-galactique';
		addAuthor: author;
		price: 2;
		didRead.
	item2 := CBookItem new
		title: 'Le guide du voyageur inter-galactique 2';
		number: 2;
		price: 2;
		addAuthor: author;
		notRead.
		
	self assert: author books size equals: 2.
]
