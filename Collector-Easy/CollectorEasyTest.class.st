Class {
	#name : #CollectorEasyTest,
	#superclass : #TestCase,
	#category : #'Collector-Easy'
}

{ #category : #'tests basic YAML' }
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

{ #category : #'tests basic YAML' }
CollectorEasyTest >> testSimpleAuthorWithSeriesSequences [

	| dict |
	dict := 
PPYAMLGrammar parse: '
sum: 11

Wilson, Charles Robert: 
 books:
   - Darwinia (250
   - Mysterium (lu une partie d''une ville est teleporte dans un monde parallele)
   - Spin (lu la terre mis dans un sachet)

Hobb: 
 chamane: 
   - 1 blpe
   - 2 blop2

zelazny:  
 books: 
   - le demon de la farce 2.25
   - seigneur de lumiere 2.25
   - Un pont de cendres 1.6
   - Leserum de la deesse bleue 2.5
 ambre:
   - 1 les neufs prince d''ambre
   - 2 la cours du chaos
 '. 

	self assert: dict size equals: 4

]

{ #category : #'tests basic YAML' }
CollectorEasyTest >> testSimpleYAMLAuthor [

	| dict |
	dict := PPYAMLGrammar parse:
'author: Wilcon, Robert Charles '. 
	self assert: (dict at: 'author') equals: 'Wilcon, Robert Charles'
]

{ #category : #'tests basic YAML' }
CollectorEasyTest >> testSimpleYAMLNoDoubleKeyAuthor [

	| dict |
	dict := PPYAMLGrammar parse:
'author: Wilcon, Robert Charles 

author: Zelazny'
. 
	self assert: (dict at: 'author') equals: 'Zelazny'
]

{ #category : #'tests basic YAML' }
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
