Class {
	#name : #CBookCollectorTest,
	#superclass : #TestCase,
	#category : #'Collector-SimpleBook-Tests'
}

{ #category : #tests }
CBookCollectorTest >> testLoadingSTON [

	| collector |
	collector := STON fromString: CBookCollector smallCollectorNoSerie asSTON.
	self assert: (collector collectionNamed: #owned) size equals: 4
]

{ #category : #tests }
CBookCollectorTest >> testNoDoubleItemAfterFlattened [

	| collection |
	collection := (CBkCollectorDLittleImporter new import: 
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
	self assert: collection items first mainAuthor books size equals: 4.
]
