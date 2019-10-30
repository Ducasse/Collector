Class {
	#name : #CBookCollector,
	#superclass : #CCollector,
	#category : #'Collector-SimpleBooks'
}

{ #category : #import }
CBookCollector class >> filename [
	^ 'Books'
]

{ #category : #examples }
CBookCollector class >> smallCollection [
	<sampleInstance>
	| collection item2 author  item1 item3 item4 |
	collection := CCollection new.
	collection name: #plain. 
	collection sorter: CByAuthorsCollectionSorter new. 
	
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
	item3 := CBookItem new
		title: 'Le guide du voyageur inter-galactique 3';
		number: 3;
		price: 2;
		addAuthor: author;
		notRead.
	item4 := CBookItem new 
		title: 'Le vaisseau des voyageurs';
		price: 2;
		addAuthor: (CBookAuthor new firstName: 'Robert Charles'; name: 'Wilson');
		didRead; 
		summary: 'La terre mise dans un sachet pour touner moins vite que le reste de l''Univers'.
	
	collection add: item1.
	collection add: item2.
	collection add: item3.
	collection add: item4.
	^ collection
]

{ #category : #examples }
CBookCollector class >> smallCollector [
	<sampleInstance>
	| collector item2 author  item1 item3 item4 |
	collector := self new.
	collector declareNewCollection: #owned.
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
	item3 := CBookItem new
		title: 'Le guide du voyageur inter-galactique 3';
		number: 3;
		price: 2;
		addAuthor: author;
		notRead.
	item4 := CBookItem new
		title: 'Le guide du voyageur inter-galactique 4';
		number: 4;
		price: 2;
		addAuthor: author;
		notRead.
	collector add: item1 to: #owned.
	collector add: item2 to: #owned.
	collector add: item3 to: #owned.
	collector add: item4 to: #owned.
	^ collector
]
