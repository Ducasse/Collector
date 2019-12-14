Class {
	#name : #CDLittleLPrinterTest,
	#superclass : #TestCase,
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
CDLittleLPrinterTest >> testPrintAuthor [
	| author printer |
	author := CCollectorDLittleImporter new extractAuthorFromString:
		          'Ducasse, Stéphane'.
	printer := CDLittleLPrinter new.
	printer printAuthorName: author.
	self assert: printer contents equals: 'author : Ducasse, Stéphane'
]

{ #category : #tests }
CDLittleLPrinterTest >> testPrintBook [
	| importer printer |
	importer := CCollectorDLittleImporter new convertAuthor: (DLittleLParser parse: self class oneAuthor).
	printer := CDLittleLPrinter new.
	self 
		assert: (printer print: importer importedCollection sorted first) 
		equals: '(title : Le printemps d''helliconia (price : 1) (read : false) (style : SF))'

]

{ #category : #tests }
CDLittleLPrinterTest >> testPrintCollection [
	| importer printer |
	importer := CCollectorDLittleImporter new import: self class oneCollection.
	printer := CDLittleLPrinter new.
	self halt.
	self
		assert:
		(printer print:
			 importer importedCollection)
		equals: '(author : Aldiss, Brian' , Character lf asString
			, Character tab asString , '(serie : helliconia'
			, Character lf asString , Character tab asString
			, Character tab asString
			,
			'(title : Le printemps d''helliconia (price : 1) (read : false) (style : SF))'
			, Character lf asString , Character tab asString
			, Character tab asString
			,
			'(title : Helliconia, l''ete (price : 1) (read : false) (style : SF))'
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
CDLittleLPrinterTest >> testPrintFullBookEntrie [
	| importer printer |
	importer := CCollectorDLittleImporter new convertAuthor:
		            (DLittleLParser parse: self class oneAuthor).
	printer := CDLittleLPrinter new.
	self
		assert:
		(printer print: importer importedCollection sorted first authors first)
		equals:
			'(author : Aldiss, Brian', Character lf asString, 
			Character tab asString, '(serie : helliconia', Character lf asString, 
			Character tab asString, Character tab asString,
			'(title : Le printemps d''helliconia (price : 1) (read : false) (style : SF))', Character lf asString, 
			Character tab asString, Character tab asString,
			'(title : Helliconia, l''ete (price : 1) (read : false) (style : SF))', Character lf asString, 
			Character tab asString, Character tab asString, '(title : L''hiver d''helliconia (price : 1) (read : false) (style : SF)))', 
			Character lf asString, 
			Character tab asString, '(serie : default', Character lf asString, 
			Character tab asString, Character tab asString, '(title : L''instant de l''eclipse (price : 1) (read : false) (style : fantaisie)))', Character lf asString, ')'
]

{ #category : #tests }
CDLittleLPrinterTest >> testPrintSerie [
	| importer printer |
	importer := CCollectorDLittleImporter new convertAuthor: (DLittleLParser parse: self class oneAuthor).
	printer := CDLittleLPrinter new.
	self 
		assert: (printer print: importer importedCollection sorted first serie) 
		equals: 
		'(serie : helliconia', Character lf asString, Character tab asString,
			'(title : Le printemps d''helliconia (price : 1) (read : false) (style : SF))', Character lf asString, Character tab asString,
			'(title : Helliconia, l''ete (price : 1) (read : false) (style : SF))', Character lf asString, Character tab asString,
			'(title : L''hiver d''helliconia (price : 1) (read : false) (style : SF))', Character lf asString, 
			')'

]
