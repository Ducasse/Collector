"
I am a copy of class CCollectorEasyYAMLTest. This comment is copied from there, and might not be entirely accurate

This class contains tests
"
Class {
	#name : #CBkCollectorDLittleImporterTest,
	#superclass : #TestCase,
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
CBkCollectorDLittleImporterTest >> testConvertAuthor [

	| ce books |
	ce := CBkCollectorDLittleImporter new 
				convertAuthor: (DLittleLParser parse: self class oneAuthor).
	books := ce importedCollection sorted.
	self assert: books size equals: 4
]

{ #category : #tests }
CBkCollectorDLittleImporterTest >> testExtractAuthor [

	| author |
	author := (CBkCollectorDLittleImporter new extractAuthorFromString: ' Wilson  ').
	self assert: author name equals: 'Wilson'.
	self assert: author firstName equals: ''
]

{ #category : #tests }
CBkCollectorDLittleImporterTest >> testExtractAuthorWithFirstNames [

	| author |
	author := (CBkCollectorDLittleImporter new extractAuthorFromString: ' Wilson  ,   Charles Robert ').
	self assert: author name equals: 'Wilson'.
	self assert: author firstName equals: 'Charles Robert'
]

{ #category : #tests }
CBkCollectorDLittleImporterTest >> testExtractBook [

	| book |
	book := (CBkCollectorDLittleImporter new bookFrom: (DLittleLParser parse: '(title : Les vents du changement (read : no) (style : SF) (price : 2.39))')).
	
	self assert: book title equals: 'Les vents du changement'.
	self assert: book price equals: 2.39.
	self assert: book style equals: 'SF'.
	self deny: book read
	
]

{ #category : #tests }
CBkCollectorDLittleImporterTest >> testExtractSerie [

	| import author |
	import := CBkCollectorDLittleImporter new.
	author := import extractAuthorFromString:  ' John'.
	import extractSerieFrom: (DLittleLParser parse: '(serie : Guide du routard galactique  
  	 		(title: Le guide du voyageur inter-galactique (read: true) (summary: un gars est capture par un vaisseau spatial et il lui arrive plein d''histoires aussi debiles les unes que les autres) (style: comic english humour))
   			(title: H2G2 2 (read: no) (style: comic english humour) (price: 2)))')
			 	withAuthor: author. 
	self assert: import importedItemSize equals: 2.
	self assert: import importedCollection items first serie name equals: 'Guide du routard galactique'
	

]

{ #category : #tests }
CBkCollectorDLittleImporterTest >> testImport [

	| ce liconia |
	ce := CBkCollectorDLittleImporter new import: self class minilist.
	self assert: ce importedItemSize equals: 8.
	liconia := ce importedCollection items select: [ :each |  '*liconia*' match: each title  ].
	self assert: liconia size equals: 3.
	liconia do: [ :each | self assert: ('*liconia*' match: each serie name) ]
]

{ #category : #tests }
CBkCollectorDLittleImporterTest >> testImport2 [

	| ce book1 |
	ce := CBkCollectorDLittleImporter new import: self class minilist.
	self assert: ce importedItemSize equals: 8.
	book1 := (ce importedCollection items select: [ :each | each title = 'Le printemps d''helliconia' ]) first.
	self assert: book1 title equals: 'Le printemps d''helliconia'.
	"with some other situations I lost the title"
	self assert: book1 authors size equals: 1.
]

{ #category : #tests }
CBkCollectorDLittleImporterTest >> testParseMinilist [

	self shouldnt: [ DLittleLParser parse: self class minilist] raise: Error
]
