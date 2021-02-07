Class {
	#name : #CObject,
	#superclass : #Object,
	#instVars : [
		'properties'
	],
	#category : #'Collector-Core'
}

{ #category : #accessing }
CObject >> ensureProperties [
	properties ifNil: [ properties := Dictionary new ].
	^ properties 
]

{ #category : #accessing }
CObject >> propertiesKeysAndValuesDo: aBlock [

	properties keysAndValuesDo: aBlock
]

{ #category : #accessing }
CObject >> propertyAt: propName [
	^ self ensureProperties
		at: propName

]

{ #category : #accessing }
CObject >> propertyAt: propName put: propValue [
	^ self ensureProperties
		at: propName
		ifAbsentPut: propValue
]

{ #category : #accessing }
CObject >> shouldConvert [ 	
	^ true
]
