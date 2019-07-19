"
ListOfClasses new on: Array; openWithSpec
"
Class {
	#name : #ListOfClassesPresenter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'listModel',
		'classItem'
	],
	#category : #'Collector-UI'
}

{ #category : #specs }
ListOfClassesPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
			add: #listModel; 
			yourself
]

{ #category : #initialization }
ListOfClassesPresenter >> initializeWidgets [
	listModel := self newList.
	 listModel
		sortingBlock: [ :cls1 :cls2 | cls1 name < cls2 name ]
]

{ #category : #accessing }
ListOfClassesPresenter >> listModel [ 
	^ listModel
]

{ #category : #initialization }
ListOfClassesPresenter >> on: aClass [
	classItem := aClass.
	listModel items: aClass withAllSubclasses
]

{ #category : #api }
ListOfClassesPresenter >> title [
	^ 'Subclass List of ' , classItem name asString
]
