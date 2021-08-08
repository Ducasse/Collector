Class {
	#name : #CServer,
	#superclass : #Object,
	#instVars : [
		'teapot',
		'books'
	],
	#category : #'Collector-Server'
}

{ #category : #'as yet unclassified' }
CServer >> routes [

	teapot
		GET: '/' -> '<h1>A simple book server</h1>'; output: #html; 
		GET: '/books' -> books;
		GET: '/books/<id:IsInteger>' -> [ :request | books at: (request at: #id) asString]; 
start.
]
