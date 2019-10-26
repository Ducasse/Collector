Class {
	#name : #CBookCollectorTest,
	#superclass : #TestCase,
	#category : #'Collector-Tests'
}

{ #category : #tests }
CBookCollectorTest >> testLoadingSTON [

	| collector |
	collector := STON fromString: 'CBookCollector {
	#fileName : ''Books'',
	#collectionDictionary : {
		#owned : OrderedCollection [
			CBookItem {
				#read : true,
				#price : 2,
				#title : ''Le guide du voyageur inter-galactique'',
				#authors : OrderedCollection [
					CBookAuthor {
						#books : OrderedCollection [
							@4,
							CBookItem {
								#read : false,
								#price : 2,
								#title : ''Le guide du voyageur inter-galactique 2'',
								#authors : OrderedCollection [
									@6
								],
								#number : 2
							},
							CBookItem {
								#read : false,
								#price : 2,
								#title : ''Le guide du voyageur inter-galactique 3'',
								#authors : OrderedCollection [
									@6
								],
								#number : 3
							},
							CBookItem {
								#read : false,
								#price : 2,
								#title : ''Le guide du voyageur inter-galactique 4'',
								#authors : OrderedCollection [
									@6
								],
								#number : 4
							}
						],
						#firstName : ''Douglas'',
						#name : ''Adam''
					}
				]
			},
			@8,
			@10,
			@12
		]
	}
}'.
	self assert: (collector collectionNamed: #owned) size equals: 4
]

{ #category : #tests }
CBookCollectorTest >> testSortedByAuthors [

	| collector |
	collector := STON fromString: 'CBookCollector {
	#fileName : ''Books'',
	#collectionDictionary : {
		#owned : OrderedCollection [
			CBookItem {
				#read : true,
				#price : 2,
				#title : ''Le guide du voyageur inter-galactique'',
				#authors : OrderedCollection [
					CBookAuthor {
						#books : OrderedCollection [
							@4,
							CBookItem {
								#read : false,
								#price : 2,
								#title : ''Le guide du voyageur inter-galactique 2'',
								#authors : OrderedCollection [
									@6
								],
								#number : 2
							},
							CBookItem {
								#read : false,
								#price : 2,
								#title : ''Le guide du voyageur inter-galactique 3'',
								#authors : OrderedCollection [
									@6
								],
								#number : 3
							},
							CBookItem {
								#read : false,
								#price : 2,
								#title : ''Le guide du voyageur inter-galactique 4'',
								#authors : OrderedCollection [
									@6
								],
								#number : 4
							}
						],
						#firstName : ''Douglas'',
						#name : ''Adam''
					}
				]
			},
			@8,
			@10,
			@12
		]
	}
}'.
	self assert: (collector collectionNamed: #owned) sorted first class equals: CBookAuthor
]
