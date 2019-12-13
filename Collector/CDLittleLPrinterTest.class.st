Class {
	#name : #CDLittleLPrinterTest,
	#superclass : #TestCase,
	#category : #'Collector-Tests'
}

{ #category : #example }
CDLittleLPrinterTest class >> oneAuthor [
	<sampleInstance>
	^ '(author : Aldiss, Brian 
  (serie : helliconia  
   		(title: Le printemps d''helliconia (read: no) (style: SF) (price: 1))
  	 	(title: Helliconia, l''ete (read: no) (style: SF) (price: 1))
 	  	(title: L''hiver d''helliconia (read: no) (style: SF) (price: 1)))
  (books : default
    	( title: L''instant de l''eclipse (read: no) (style: fantaisie) (price: 1))))'
]

{ #category : #tests }
CDLittleLPrinterTest >> testPrintAuthor [
	| author printer |
	author := CCollectorDLittleImporter new extractAuthorFromString: 'Ducasse, Stéphane'.
	printer := CDLittleLPrinter new.
	printer printAuthorName: author.
	self assert: printer contents equals: '(author : Ducasse, Stéphane)'
	
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
CDLittleLPrinterTest >> testPrintFullBookEntrie [
	| importer printer |
	importer := CCollectorDLittleImporter new convertAuthor:
		            (DLittleLParser parse: self class oneAuthor).
	printer := CDLittleLPrinter new.
	self
		assert:
		(printer print: importer importedCollection sorted first authors first)
		equals:
			'(serie : helliconia', Character lf asString, Character tab asString,
			'(title : Le printemps d''helliconia (price : 1) (read : false) (style : SF))', 
			Character lf asString, Character tab asString,
			'(title : Helliconia, l''ete (price : 1) (read : false) (style : SF))', Character lf asString, 
			Character tab asString, '(title : L''hiver d''helliconia (price : 1) (read : false) (style : SF))', 
			Character lf asString, ')'
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