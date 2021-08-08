"
``` 
( CServer serveOn: 9042 ) inspect
```
"
Class {
	#name : #CServer,
	#superclass : #Object,
	#instVars : [
		'teapot'
	],
	#category : #'Collector-Server'
}

{ #category : #'instance creation' }
CServer class >> serveOn: portNumber [
	^ self new  
		initializePort: portNumber;
		start
]

{ #category : #serving }
CServer >> bookNotFound: aBookNotFound request: aZnRequest [
	^ TeaResponse notFound body:
		{ 
			#code -> 'NOT_FOUND'. 
			#message -> ('No such book: ', aBookNotFound bookId asString)
		} asDictionary
]

{ #category : #initialization }
CServer >> books [ 
	"could do a refresh because it is a bit ultimate."
	
	^ CFiler new copyToLocal; loadFileInMemory;  books
]

{ #category : #initialization }
CServer >> initializePort: anInteger [

	teapot := Teapot configure: { 
		#port -> anInteger. 
		#debugMode -> true. 
		#defaultOutput -> #json 
	}.

	^ self 
		registerRoutes;
		registerErrorHandlers;
		yourself
]

{ #category : #serving }
CServer >> missingParam: aTeaNoSuchParam request: aZnRequest [
	^ TeaResponse badRequest body:
		{ 
			#code -> 'MALFORMED_INPUT'. 
			#message -> ('Missing parameter: ', aTeaNoSuchParam param)
		} asDictionary
]

{ #category : #serving }
CServer >> registerErrorHandlers [
	teapot
		exception: TeaNoSuchParam -> (Send message: #missingParam:request: to: self);
		exception: BookNotFound -> (Send message: #bookNotFound:request: to: self);
		exception: Error -> (TeaResponse serverError body: { #code -> 'ERROR' } asDictionary )		
]

{ #category : #serving }
CServer >> registerRoutes [

	teapot
		GET: '/' -> ('<h1>A simple book server ---', Time now asString, '</h1>'); output: #html; 
		GET: '/books' -> [ :request | self books]; output: #text;
		GET: '/books/<id:IsInteger>' -> [ :request | self books at: (request at: #id) asString]; 
		start.
]

{ #category : #initialization }
CServer >> start [
	teapot start.
	^ self
]

{ #category : #initialization }
CServer >> stop [
	teapot stop
]
