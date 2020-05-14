Class {
	#name : #CDLittleLPrinterTest,
	#superclass : #TestCase,
	#instVars : [
		'printer'
	],
	#category : #'Collector-Tests'
}

{ #category : #example }
CDLittleLPrinterTest class >> oneAuthor [

	^ '(author : Aldiss, Brian 
  (serie : helliconia  
   		(title: Le printemps d''helliconia (read: no) (style: SF) (price: 1))
  	 	(title: Helliconia, l''ete (read: no) (style: SF) (price: 1))
 	  	(title: L''hiver d''helliconia (read: no) (style: SF) (price: 1)))
  (books : default
    	( title: L''instant de l''eclipse (read: no) (style: fantaisie) (price: 1))))'
]

{ #category : #example }
CDLittleLPrinterTest class >> oneCollection [

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
CDLittleLPrinterTest >> printer [
	^ CDLittleLPrinter new
]

{ #category : #tests }
CDLittleLPrinterTest >> setUp [ 
	super setUp.
	printer := self printer.
]

{ #category : #tests }
CDLittleLPrinterTest >> testPrintAuthor [
	| author  |
	author := CBkCollectorDLittleImporter new
		extractAuthorFromString: 'Ducasse, Stéphane'.
	
	printer printAuthorName: author.
	self assert: printer contents equals: 'author : Ducasse, Stéphane'
]

{ #category : #tests }
CDLittleLPrinterTest >> testPrintBook [
	| importer  |
	importer := CBkCollectorDLittleImporter new 
		convertAuthor: (DLittleLParser parse: self class oneAuthor).
	
	printer print: importer importedCollection sorted first.
	self 
		assert: printer contents
		equals: '(title : Le printemps d''helliconia (price : 1) (read : false) (style : SF))'

]

{ #category : #tests }
CDLittleLPrinterTest >> testPrintCollection [
	| importer |
	importer := CBkCollectorDLittleImporter new
		import: self class oneCollection.
	
	printer print: importer importedCollection.
	self
		assert: printer contents
		equals:
			'(collection : SF' , Character lf asString , Character tab asString
				, '(author : Adam, Douglas' , Character lf asString
				, Character tab asString , Character tab asString
				, '(serie : Guide du routard galactique' , Character lf asString
				, Character tab asString , Character tab asString
				, Character tab asString
				,
					'(title : Le guide du voyageur inter-galactique (read : true) (style : comic english humour) (summary : un gars est capture par un vaisseau spatial et il lui arrive plein d''histoires aussi debiles les unes que les autres))'
				, Character lf asString , Character tab asString
				, Character tab asString , Character tab asString
				,
					'(title : H2G2 2 (price : 2) (read : false) (style : comic english humour))'
				, Character lf asString , Character tab asString
				, Character tab asString , Character tab asString
				,
					'(title : H2G2 3 (price : 2) (read : false) (style : comic english humour))'
				, Character lf asString , Character tab asString
				, Character tab asString , Character tab asString
				,
					'(title : H2G2 4 (price : 2) (read : false) (style : comic english humour)))'
				, Character lf asString , Character tab asString , ')'
				, Character lf asString , Character tab asString
				, '(author : Aldiss, Brian' , Character lf asString
				, Character tab asString , Character tab asString
				, '(serie : helliconia' , Character lf asString
				, Character tab asString , Character tab asString
				, Character tab asString
				,
					'(title : Le printemps d''helliconia (price : 1) (read : false) (style : SF))'
				, Character lf asString , Character tab asString
				, Character tab asString , Character tab asString
				, '(title : Helliconia, l''ete (price : 1) (read : false) (style : SF))'
				, Character lf asString , Character tab asString
				, Character tab asString , Character tab asString
				,
					'(title : L''hiver d''helliconia (price : 1) (read : false) (style : SF)))'
				, Character lf asString , Character tab asString
				, Character tab asString , '(serie : default'
				, Character lf asString , Character tab asString
				, Character tab asString , Character tab asString
				,
					'(title : L''instant de l''eclipse (price : 1) (read : false) (style : fantaisie)))'
				, Character lf asString , Character tab asString , ')'
				, Character lf asString , Character tab asString , '( sum : 8))'
]

{ #category : #tests }
CDLittleLPrinterTest >> testPrintFullBookEntrie [
	| importer |
	importer := CBkCollectorDLittleImporter new
		convertAuthor: (DLittleLParser parse: self class oneAuthor).
	
	printer print: importer importedCollection sorted first authors first.
	self
		assert: printer contents
		equals:
			'(author : Aldiss, Brian' , Character lf asString
				, Character tab asString , '(serie : helliconia'
				, Character lf asString , Character tab asString
				, Character tab asString
				,
					'(title : Le printemps d''helliconia (price : 1) (read : false) (style : SF))'
				, Character lf asString , Character tab asString
				, Character tab asString
				, '(title : Helliconia, l''ete (price : 1) (read : false) (style : SF))'
				, Character lf asString , Character tab asString
				, Character tab asString
				,
					'(title : L''hiver d''helliconia (price : 1) (read : false) (style : SF)))'
				, Character lf asString , Character tab asString
				, '(serie : default' , Character lf asString
				, Character tab asString , Character tab asString
				,
					'(title : L''instant de l''eclipse (price : 1) (read : false) (style : fantaisie)))'
				, Character lf asString , ')'
]

{ #category : #tests }
CDLittleLPrinterTest >> testPrintSerie [
	| importer |
	importer := CBkCollectorDLittleImporter new
		convertAuthor: (DLittleLParser parse: self class oneAuthor).

	printer print: importer importedCollection sorted first serie.
	self
		assert: printer contents
		equals:
			'(serie : helliconia' , Character lf asString , Character tab asString
				,
					'(title : Le printemps d''helliconia (price : 1) (read : false) (style : SF))'
				, Character lf asString , Character tab asString
				, '(title : Helliconia, l''ete (price : 1) (read : false) (style : SF))'
				, Character lf asString , Character tab asString
				,
					'(title : L''hiver d''helliconia (price : 1) (read : false) (style : SF)))'
]
