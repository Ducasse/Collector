"
Idea of possible declaration for domain

(entities : bookCollection 
	(domain : author
		(containment (domain : serie))
	(domain : serie 
		(containement (domain: book))
	(domain : book
		(field : number
			(type : number)
		(field : read
			(type : boolean)
			(occurence : mandatory)
	)

"
Class {
	#name : #CCollectorDLittleDomainCreatorTest,
	#superclass : #TestCase,
	#instVars : [
		'creator'
	],
	#category : #'Collector-Book-DLittleImporter2'
}
