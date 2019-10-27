Class {
	#name : #CBookCollectionTest,
	#superclass : #TestCase,
	#category : #'Collector-Tests'
}

{ #category : #tests }
CBookCollectionTest >> testSorted [ 

	| c s |
	c := CBookCollector smallCollection.
	self assert: c size equals: 4.
	
	"when we sort book we do not get anymore all the books in on row but the authors."
	s := c sorted. 
	self assert: s size equals: 2.
	self assert: s first name equals: 'Adam'.
	self assert: s last name equals: 'Wilson'.
	
	self assert: s first books size equals: 3
]

{ #category : #tests }
CBookCollectionTest >> testSortedByAuthors [

	| collector |
	"the Ston string was generated using CBookCollector smallCollection asSTON"
	collector := STON fromString: 'CCollection {
	#tag : #plain,
	#items : OrderedCollection [
		CBookItem {
			#read : true,
			#price : 2,
			#title : ''Le guide du voyageur inter-galactique'',
			#authors : OrderedCollection [
				CBookAuthor {
					#books : OrderedCollection [
						@3,
						CBookItem {
							#read : false,
							#price : 2,
							#title : ''Le guide du voyageur inter-galactique 2'',
							#authors : OrderedCollection [
								@5
							],
							#number : 2
						},
						CBookItem {
							#read : false,
							#price : 2,
							#title : ''Le guide du voyageur inter-galactique 3'',
							#authors : OrderedCollection [
								@5
							],
							#number : 3
						}
					],
					#firstName : ''Douglas'',
					#name : ''Adam''
				}
			]
		},
		@7,
		@9,
		CBookItem {
			#read : true,
			#summary : ''La terre mise dans un sachet pour touner moins vite que le reste de l\''Univers'',
			#price : 2,
			#title : ''Le vaisseau des voyageurs'',
			#authors : OrderedCollection [
				CBookAuthor {
					#books : OrderedCollection [
						@11
					],
					#firstName : ''Robert Charles'',
					#name : ''Wilson''
				}
			]
		}
	],
	#sorter : CByAuthorsCollectionSorter { }
}'.
	self assert: collector sorted first class equals: CBookAuthor.
	self assert: collector sorted first  equals: CBookAuthor.
]
