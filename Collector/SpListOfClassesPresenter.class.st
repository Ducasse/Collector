"
ListOfClasses new on: Array; openWithSpec
"
Class {
	#name : #SpListOfClassesPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'listModel',
		'classItem'
	],
	#category : #'Collector-UI'
}

{ #category : #specs }
SpListOfClassesPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
			add: #listModel; 
			yourself
]

{ #category : #initialization }
SpListOfClassesPresenter >> initializeWidgets [
	listModel := self newList.
	listModel
		sortingBlock: [ :cls1 :cls2 | cls1 name < cls2 name ]
]

{ #category : #accessing }
SpListOfClassesPresenter >> listModel [ 
	^ listModel
]

{ #category : #initialization }
SpListOfClassesPresenter >> on: aClass [
	classItem := aClass.
	listModel items: aClass withAllSubclasses
]

{ #category : #api }
SpListOfClassesPresenter >> title [
	^ 'Subclass List of ' , classItem name asString
]
