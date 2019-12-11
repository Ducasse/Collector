"
I'm basic printer used to output nicely collection so that the parser can parse the output correctly.

For example here is a given output

(author : Aldiss, Brian 
  (serie : helliconia  
   		(title: Le printemps d''helliconia (read: no) (style: SF) (price: 1))
  	 	(title: Helliconia, l''ete (read: no) (style: SF) (price: 1))
 	  	(title: L''hiver d''helliconia (read: no) (style: SF) (price: 1)))
  (books : default
    	( title: L''instant de l''eclipse (read: no) (style: fantaisie) (price: 1))))
"
Class {
	#name : #CDLittleLPrinter,
	#superclass : #CSimpleBookVisitor,
	#instVars : [
		'stream',
		'tabs'
	],
	#category : #'Collector-SimpleBooks'
}

{ #category : #initialization }
CDLittleLPrinter >> initialize [ 
	super initialize.
	stream := WriteStream on: ''.
	tabs := 0
]

{ #category : #printing }
CDLittleLPrinter >> print: aCcollection [ 

	aCcollection accept: self.
	^ stream contents
]

{ #category : #visiting }
CDLittleLPrinter >> visitAuthor: anAuthor [
	
	stream << '(author : '.
	stream << anAuthor name.
	stream << ', '.
	stream << anAuthor firstName.
	stream << ')'
]

{ #category : #visiting }
CDLittleLPrinter >> visitBook: aBook [

	stream << '(title : '.
	stream << aBook title.
	(aBook class instVarNames asOrderedCollection removeAll: #(#title #authors #serie) ; yourself) sorted
	"kind of primary key and foreign key"
	do: [ :each | 
			| value |
			value := aBook perform: each.
			value ifNotNil: [  
			stream << ' ('.
			stream << each asString. 
			stream << ' : '. 
			stream << value  asString.
			stream << ')' ] ].
 	stream << ')'
]

{ #category : #visiting }
CDLittleLPrinter >> visitCollection: aCollection [
	self halt. 
	stream << '(collection : '.
	stream << aCollection name.
	aCollection items sorted do: [ :each | each accept: self ].
	stream << '( sum : ', aCollection items size asString, '))'.
]
