"
I am a copy of class CCollectorEasyYAMLTest. This comment is copied from there, and might not be entirely accurate

This class contains tests
"
Class {
	#name : #CBkCollectorDLittleImporterTest,
	#superclass : #TestCase,
	#instVars : [
		'importer'
	],
	#category : #'Collector-Book-DLittleImporter'
}

{ #category : #resources }
CBkCollectorDLittleImporterTest class >> minilist [

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
CBkCollectorDLittleImporterTest class >> oneAuthor [

	^ '(author : Aldiss, Brian 
		(serie : helliconia  
  	 		(title: Le printemps d''helliconia (read: no)  (style: SF) (price: 1))
  		 	(title: Helliconia, l''ete (read: no)  (style: SF) (price: 1))
 	 	 	(title: L''hiver d''helliconia (read: no)  (style: SF) (price: 1)))
 	 	(books : default
  	 	 	( title: L''instant de l''eclipse (read: no)  (style: fantaisie) (price: 1))))'
]

{ #category : #tests }
CBkCollectorDLittleImporterTest >> importer [
	^ CBkCollectorDLittleImporter new
]

{ #category : #running }
CBkCollectorDLittleImporterTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	super setUp. 
	importer := self importer
]

{ #category : #tests }
CBkCollectorDLittleImporterTest >> testConvertAuthor [

	| ce books |
	ce := importer convertAuthor: (DLittleLParser parse: self class oneAuthor).
	books := ce importedCollection sorted.
	self assert: books size equals: 4.
	self assert: books first authors first books size equals: 4
]

{ #category : #tests }
CBkCollectorDLittleImporterTest >> testExtractAuthor [
	| author |
	author := importer extractAuthorFromString: ' Wilson  '.
	self assert: author name equals: 'Wilson'.
	self assert: author firstName equals: ''
]

{ #category : #tests }
CBkCollectorDLittleImporterTest >> testExtractAuthorWithFirstNames [
	| author |
	author := importer extractAuthorFromString: ' Wilson  ,   Charles Robert '.
	self assert: author name equals: 'Wilson'.
	self assert: author firstName equals: 'Charles Robert'
]

{ #category : #tests }
CBkCollectorDLittleImporterTest >> testExtractBook [
	| book |
	book := importer
		bookFrom:
			(DLittleLParser
				parse:
					'(title : Les vents du changement (read : no) (style : SF) (price : 2.39))').
	self assert: book title equals: 'Les vents du changement'.
	self assert: book price equals: 2.39.
	self assert: book style equals: 'SF'.
	self deny: book read
]

{ #category : #tests }
CBkCollectorDLittleImporterTest >> testExtractSerie [
	|  author |
	author := importer extractAuthorFromString: ' John'.
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
		equals: 'Guide du routard galactique'
]

{ #category : #tests }
CBkCollectorDLittleImporterTest >> testImport [
	| ce liconia |
	ce := importer import: self class minilist.
	self assert: ce importedItemSize equals: 8.
	liconia := ce importedCollection items
		select: [ :each | '*liconia*' match: each title ].
	self assert: liconia size equals: 3.
	liconia
		do: [ :each | self assert: ('*liconia*' match: each serie name) ]
]

{ #category : #tests }
CBkCollectorDLittleImporterTest >> testImport2 [
	| ce book1 |
	ce := importer import: self class minilist.
	self assert: ce importedItemSize equals: 8.
	book1 := (ce importedCollection items
		select: [ :each | each title = 'Le printemps d''helliconia' ]) first.
	self assert: book1 title equals: 'Le printemps d''helliconia'.
	"with some other situations I lost the title"
	self assert: book1 authors size equals: 1
]

{ #category : #tests }
CBkCollectorDLittleImporterTest >> testNoDoubleItemAfterImport [
	| collection |
	collection := (self importer
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
			(title : La horde du hurlevent (price : 1.5) (read : false)))
	)
	(author : Aldiss, Brian
		(serie : books
			(title : L''instant de l''eclipse (price : 1) (read : false) (style : fantaisie)))
		(serie : helliconia
			(title : Le printemps d''helliconia (price : 1) (read : false) (style : SF))
			(title : Helliconia, l''ete (price : 1) (read : false) (style : SF))
			(title : L''hiver d''helliconia (price : 1) (read : false) (style : SF)))
	)
	( sum : 12 ))') importedCollection.
	self assert: collection size equals: 12.
	"but the problem is that importer is adding twice a book to the author."
	self
		assert: collection items first authors first books size
		equals: 4
]

{ #category : #tests }
CBkCollectorDLittleImporterTest >> testParseMinilist [

	self shouldnt: [ DLittleLParser parse: self class minilist] raise: Error
]
