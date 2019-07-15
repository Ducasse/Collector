"
ListOfClasses new on: Array; openWithSpec
"
Class {
	#name : #ListOfClasses,
	#superclass : #ComposablePresenter,
	#instVars : [
		'listModel',
		'classItem'
	],
	#category : #'Collector-UI'
}

{ #category : #specs }
ListOfClasses class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :column | column add: #listModel ];
		yourself
]

{ #category : #initialization }
ListOfClasses >> initializeWidgets [
	listModel := self newList.
	 listModel
		sortingBlock: [ :cls1 :cls2 | cls1 name < cls2 name ]
]

{ #category : #accessing }
ListOfClasses >> listModel [ 
	^ listModel
]

{ #category : #initialization }
ListOfClasses >> on: aClass [
	classItem := aClass.
	listModel items: aClass withAllSubclasses
]

{ #category : #api }
ListOfClasses >> title [
	^ 'Subclass List of ' , classItem name asString
]
