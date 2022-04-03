Class {
	#name : #CBkDetailPresenter,
	#superclass : #SpPresenter,
	#traits : 'SpTModel',
	#classTraits : 'SpTModel classTrait',
	#category : #'Collector-BookUI'
}

{ #category : #layout }
CBkDetailPresenter >> defaultLayout [ 
	
	^ SpBoxLayout newTopToBottom 
]
