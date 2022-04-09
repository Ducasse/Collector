Class {
	#name : #CBkDLittleImporterTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'importer',
		'importerClass'
	],
	#category : #'Collector-Book-DLittleImporter3'
}

{ #category : #resources }
CBkDLittleImporterTest class >> minilist [

	^ '
(collection: SFBooks
	(author : Adam, Douglas 
		(serie : Guide du routard galactique  
  	 		(title: Le guide du voyageur inter-galactique (read: true) (summary: un gars est capture par un vaisseau spatial et il lui arrive plein d''histoires aussi debiles les unes que les autres) (style: comic english humour))
   			(title: H2G2 2 (read: no) (style: comic english humour) (price: 2))
			(title: H2G2 3 (read: no) (style: comic english humour) (price: 2))
			(title: H2G2 4 (read: no) (style: comic english humour) (price: 2))))
 
	(author : Aldiss, Brian 
  		(serie : helliconia  
   			(title: Le printemps d''helliconia (read: no)  (style: SF) (price: 1))
  	 		(title: Helliconia l''ete (read: no)  (style: SF) (price: 1))
 	  		(title: L''hiver d''helliconia (read: no)  (style: SF) (price: 1)))
  	(books: individual
    	(title: L''instant de l''eclipse (read: no) (style: fantaisie) (price: 1))))
(sum : 8))'
]

{ #category : #resources }
CBkDLittleImporterTest class >> oneAuthor [

	^ '(author : Aldiss, Brian 
		(serie : helliconia  
  	 		(title: Le printemps d''helliconia (read: no)  (style: SF) (price: 1))
  		 	(title: Helliconia, l''ete (read: no)  (style: SF) (price: 1))
 	 	 	(title: L''hiver d''helliconia (read: no)  (style: SF) (price: 1)))
 	 	(books : default
  	 	 	( title: L''instant de l''eclipse (read: no)  (style: fantaisie) (price: 1))))'
]

{ #category : #tests }
CBkDLittleImporterTest class >> testParameters [

	^ ParametrizedTestMatrix new
			addCase: { #importerClass -> CBkCollectorDLittleImporter };
		yourself.
]

{ #category : #tests }
CBkDLittleImporterTest >> importerClass: anImporterClass [
	importerClass := anImporterClass
]

{ #category : #tests }
CBkDLittleImporterTest >> setUp [ 
	super setUp.
	importer := importerClass new.
]

{ #category : #tests }
CBkDLittleImporterTest >> testConvertAuthor [

	| ce books |
	ce := importer convertAuthor: (DLittleLParser parse: self class oneAuthor).
	books := ce importedCollection sortedItems.
	self assert: books size equals: 4.
	self assert: books first authors first books size equals: 4.
	
	self assert: books first authors first series size equals: 2.
	self assert: books first authors first series first books size equals: 3.
	self assert: books first authors first series second books size equals: 1
]

{ #category : #'test extraction' }
CBkDLittleImporterTest >> testExtractAuthorEntity [
	| author |
	author := importer extractAuthorEntityFromString: ' Wilson  '.
	self assert: author name equals: 'Wilson'.
	self assert: author firstName equals: ''
]

{ #category : #'test extraction' }
CBkDLittleImporterTest >> testExtractAuthorWithFirstNames [
	| author |
	author := importer extractAuthorEntityFromString: ' Wilson  ,   Charles Robert '.
	self assert: author name equals: 'Wilson'.
	self assert: author firstName equals: 'Charles Robert'
]

{ #category : #'test extraction' }
CBkDLittleImporterTest >> testExtractBook [
	| book |
	book := importer
		bookFrom:
			(DLittleLParser
				parse:
					'(title : Les vents du changement (read : no) (style : SF) (price : 2.39))').
	self assert: book title equals: 'Les vents du changement'.
	self assert: book price equals: 2.39.
	self assert: book style equals: 'SF'.
	self deny: book read.
	
	"since it is nested in parent (serie or author) we do not set the author yet."
	self assert: book authors isEmpty.
	
]

{ #category : #tests }
CBkDLittleImporterTest >> testExtractSerie [
	|  author |
	self assert: importer importedItemSize equals: 0.
	author := importer extractAuthorEntityFromString: ' John'.
	importer
		extractSerieFrom:
			(DLittleLParser
				parse:
					'(serie : Guide du routard galactique  
  	 		(title: Le guide du voyageur inter-galactique (read: true) (summary: un gars est capture par un vaisseau spatial et il lui arrive plein d''histoires aussi debiles les unes que les autres) (style: comic english humour))
   			(title: H2G2 2 (read: no) (style: comic english humour) (price: 2)))')
		withAuthor: author.
	self assert: importer importedItemSize equals: 2.
	
	self
		assert: importer importedCollection items first serie name
		equals: 'Guide du routard galactique'.
	self assert: importer importedCollection items first mainAuthor books size equals: 2
]

{ #category : #tests }
CBkDLittleImporterTest >> testExtractSerieWithBooksSection [
	| author books |
	author := importer extractAuthorEntityFromString: ' John'.
	importer
		extractSerieFrom: (DLittleLParser parse: '(books : default
  	 	 	( title: L''instant de l''eclipse (read: no)  (style: fantaisie) (price: 1)))')
		withAuthor: author.
	self assert: importer importedItemSize equals: 1.
	books := importer importedCollection items.
	self
		assert: (books collect: [ :bk | bk serie ]) size
		equals: 1.
	
]

{ #category : #tests }
CBkDLittleImporterTest >> testImport [
	| ce liconia |
	self assert: importer importedItemSize equals: 0.
	ce := importer import: self class minilist.
	self assert: ce importedItemSize equals: 8.
	liconia := ce importedCollection items
		select: [ :each | '*liconia*' match: each title ].
	self assert: liconia size equals: 3.
	liconia
		do: [ :each | self assert: ('*liconia*' match: each serie name) ]
]

{ #category : #tests }
CBkDLittleImporterTest >> testImport2 [
	| ce book1 |
	self assert: importer importedItemSize equals: 0.
	ce := importer import: self class minilist.
	self assert: ce importedItemSize equals: 8.
	book1 := (ce importedCollection items
		select: [ :each | each title = 'Le printemps d''helliconia' ]) first.
	self assert: book1 title equals: 'Le printemps d''helliconia'.
	self assert: book1 authors size equals: 1
]

{ #category : #tests }
CBkDLittleImporterTest >> testNoDoubleItemAfterImport [
	| collection |
	self assert: importer importedItemSize equals: 0.
	collection := (importer
		import:
			'(collection : SF
	(author : Adam, Douglas
		(serie : books
			(title : Le guide du voyageur inter-galactique (read : true) (style : comic english humour) (summary : un gars est capture par un vaisseau spatial et il lui arrive plein d''histoire aussi debiles les unes que les autres))
			(title : H2G2 2 (price : 2) (read : false) (style : comic english humour))
			(title : H2G2 3 (price : 2) (read : false) (style : comic english humour))
			(title : H2G2 4 (price : 2) (read : false) (style : comic english humour)))
	)
	(author : Alain Damasio, 
		(serie : books
			(title : Aucun souvenir assez solide (comments : lu nouvelles carrement bizarre) (read : false))
			(title : So phare away (comments : lu nouvelles carrement) (read : false))
			(title : La zone du dehors (read : false))
			(title : Helliconia, l''''ete (price : 1) (read : false) (style : SF))
			(title : La horde du hurlevent (price : 1.5) (read : false)))
	)
	(author : Aldiss, Brian
		(serie : books
			(title : L''instant de l''eclipse (price : 1) (read : false) (style : fantaisie)))
		(serie : helliconia
			(title : Le printemps d''helliconia (price : 1) (read : false) (style : SF))
			
			(title : L''hiver d''helliconia (price : 1) (read : false) (style : SF)))
	)
	( sum : 12 ))') importedCollection.
	self assert: collection size equals: 12.
	"but the problem is that importer is adding twice a book to the author."
	self
		assert: collection items first authors first books size
		equals: 4.
	self
		assert: collection items fifth authors first books size
		equals: 5.



]

{ #category : #tests }
CBkDLittleImporterTest >> testSimpleParseMinilist [

	self shouldnt: [ DLittleLParser parse: self class minilist] raise: Error
]
