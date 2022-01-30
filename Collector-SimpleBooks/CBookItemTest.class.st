Class {
	#name : #CBookItemTest,
	#superclass : #TestCase,
	#category : #'Collector-SimpleBooks-Tests'
}

{ #category : #tests }
CBookItemTest >> testBackLinksBetweenSerieAndBooks [
	
	| author serie item1 item2 |
	author := (CBookAuthor new firstName: 'Douglas'; name: 'Adam').
	serie := (CBookSerie new name: 'Guide').
	
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
	serie add: item1. 
	serie add: item2.	
	self assert: author series size equals: 1.
]

{ #category : #tests }
CBookItemTest >> testBackLinksBetweenSingleBooksAndAuthor [
	
	| author |
	author := (CBookAuthor new firstName: 'Douglas'; name: 'Adam').
	CBookItem new
		title: 'Le guide du voyageur inter-galactique';
		addAuthor: author;
		price: 2;
		didRead.
	CBookItem new
		title: 'Le guide du voyageur inter-galactique 2';
		number: 2;
		price: 2;
		addAuthor: author;
		notRead.
		
	self assert: author books size equals: 2.
]
