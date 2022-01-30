Class {
	#name : #CDCompactBookPrinterTest,
	#superclass : #TestCase,
	#instVars : [
		'printer'
	],
	#category : #'Collector-SimpleBooks-Tests'
}

{ #category : #example }
CDCompactBookPrinterTest class >> oneAuthor [

	^ '(author : Aldiss, Brian 
  (serie : helliconia  
   		(title: Le printemps d''helliconia (read: no) (style: SF) (price: 1))
  	 	(title: Helliconia, l''ete (read: no) (style: SF) (price: 1))
 	  	(title: L''hiver d''helliconia (read: no) (style: SF) (price: 1)))
  (books : default
    	( title: L''instant de l''eclipse (read: no) (style: fantaisie) (price: 1))))'
]

{ #category : #example }
CDCompactBookPrinterTest class >> oneCollection [

	^ '(collection: SF
			(author : Aldiss, Brian 
  (serie : helliconia  
   		(title: Le printemps d''helliconia (read: no) (style: SF) (price: 1))
  	 	(title: Helliconia, l''ete (read: no) (style: SF) (price: 1))
 	  	(title: L''hiver d''helliconia (read: no) (style: SF) (price: 1)))
  (books : default
    	( title: L''instant de l''eclipse (read: no) (style: fantaisie) (price: 1))))
	
	(author : Adam, Douglas 
		(serie : Guide du routard galactique  
  	 		(title: Le guide du voyageur inter-galactique (read: true) (summary: un gars est capture par un vaisseau spatial et il lui arrive plein d''histoires aussi debiles les unes que les autres) (style: comic english humour))
   			(title: H2G2 2 (read: no) (style: comic english humour) (price: 2))
			(title: H2G2 3 (read: no) (style: comic english humour) (price: 2))
			(title: H2G2 4 (read: no) (style: comic english humour) (price: 2))))
	(sum : 8))	
	'
]

{ #category : #tests }
CDCompactBookPrinterTest >> printer [
	^ CDCompactBookPrinter new
]

{ #category : #tests }
CDCompactBookPrinterTest >> setUp [ 
	super setUp.
	printer := self printer.
]

{ #category : #tests }
CDCompactBookPrinterTest >> testPrintAuthor [
	| author  |
	author := CBkCollectorDLittleImporter new
		extractAuthorFromString: 'Ducasse, Stéphane'.
	printer printAuthor: author.
	self assert: printer contents equals: 'S Ducasse'
]

{ #category : #tests }
CDCompactBookPrinterTest >> testPrintAuthorWithJustAName [
	| author  |
	author := CBkCollectorDLittleImporter new
		extractAuthorFromString: 'Barjavel'.
	printer printAuthor: author.
	self assert: printer contents equals: 'Barjavel'
]

{ #category : #tests }
CDCompactBookPrinterTest >> testPrintBookOutOfSerie [
	| importer  |
	importer := CBkCollectorDLittleImporter new 
		convertAuthor: (DLittleLParser parse: self class oneAuthor).
	printer printBook: importer importedCollection sortedItems first.
	self 
		assert: printer contents
		equals: 'B Aldiss S-helliconia: Le printemps d''helliconia'

]

{ #category : #tests }
CDCompactBookPrinterTest >> testPrintBookOutOfSerieWithNumber [
	| importer  book |
	importer := CBkCollectorDLittleImporter new 
		convertAuthor: (DLittleLParser parse: self class oneAuthor).
	book := importer importedCollection sortedItems first.
	book number: 1.
	printer printBook: book.
	self 
		assert: printer contents
		equals: 'B Aldiss S-helliconia: Le printemps d''helliconia (n:1)'

]

{ #category : #tests }
CDCompactBookPrinterTest >> testPrintCollection [
	| importer |
	importer := CBkCollectorDLittleImporter new import: self class oneCollection.
	printer printCollection: importer importedCollection.
	
	self
		assert: printer contents equals: 'B Aldiss S-helliconia: Le printemps d''helliconia
B Aldiss S-helliconia: Helliconia, l''ete
B Aldiss S-helliconia: L''hiver d''helliconia
B Aldiss S-default: L''instant de l''eclipse
D Adam S-Guide du routard galactique: Le guide du voyageur inter-galactique
D Adam S-Guide du routard galactique: H2G2 2
D Adam S-Guide du routard galactique: H2G2 3
D Adam S-Guide du routard galactique: H2G2 4'
		
]

{ #category : #tests }
CDCompactBookPrinterTest >> testPrintFullAuthorEntries [
	| importer |
	importer := CBkCollectorDLittleImporter new
		convertAuthor: (DLittleLParser parse: self class oneAuthor).
	
	printer printSeriesOfAuthor: importer importedCollection sortedItems first authors first.
	self
		assert: printer contents 
		equals: 'B Aldiss S-helliconia: Le printemps d''helliconia
B Aldiss S-helliconia: Helliconia, l''ete
B Aldiss S-helliconia: L''hiver d''helliconia
B Aldiss S-default: L''instant de l''eclipse
'
			
]

{ #category : #tests }
CDCompactBookPrinterTest >> testPrintSerie [
	| importer |
	importer := CBkCollectorDLittleImporter new
		convertAuthor: (DLittleLParser parse: self class oneAuthor).

	printer printSerie: importer importedCollection sortedItems first serie.
	self
		assert: printer contents
		equals:
			'B Aldiss S-helliconia: Le printemps d''helliconia', String lf, 
'B Aldiss S-helliconia: Helliconia, l''ete', String lf,
'B Aldiss S-helliconia: L''hiver d''helliconia'
]
