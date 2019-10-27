Class {
	#name : #CollectorEasyTest,
	#superclass : #TestCase,
	#category : #'Collector-Easy'
}

{ #category : #tests }
CollectorEasyTest >> testSimpleAuthorSequences [

	| dict |
	dict := PPYAMLGrammar parse:
'
Wilcon, Robert Charles: 
      - Darwinia (250)
      - Mysterium (lu une partie d''une ville est teleporte dans un monde parallele)
      - Spin (lu la terre mis dans un sachet)
Zelasny:
      - Les neuf princes d''ambre
'. 

	self assert: dict size equals: 2

]

{ #category : #tests }
CollectorEasyTest >> testSimpleYAMLAuthor [

	| dict |
	dict := PPYAMLGrammar parse:
'author: Wilcon, Robert Charles '. 
	self assert: (dict at: 'author') equals: 'Wilcon, Robert Charles'
]

{ #category : #tests }
CollectorEasyTest >> testSimpleYAMLNoDoubleKeyAuthor [

	| dict |
	dict := PPYAMLGrammar parse:
'author: Wilcon, Robert Charles 

author: Zelazny'
. 
	self assert: (dict at: 'author') equals: 'Zelazny'
]

{ #category : #tests }
CollectorEasyTest >> testSimpleYAMLSequences [

	| dict |
	dict := PPYAMLGrammar parse:
'
- Darwinia (250)
- Mysterium (lu une partie d''une ville est teleporte dans un monde parallele)
- Spin (lu la terre mis dans un sachet)
'. 
	self assert: dict size equals: 3.

]
