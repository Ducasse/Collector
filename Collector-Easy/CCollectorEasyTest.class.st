Class {
	#name : #CCollectorEasyTest,
	#superclass : #TestCase,
	#category : #'Collector-Easy-Importer'
}

{ #category : #resources }
CCollectorEasyTest >> minilist [

	^ 'Adam, Douglas : 
  books: 
   - {title: Le guide du voyageur inter-galactique, read: true, summary: "un gars est capture par un vaisseau spatial et il lui arrive plein d''histoire aussi debiles les unes que les autres", style: comic english humour}
   - {title: H2G2 2, read: no,  style: comic english humour, price: 2}
   - {title: H2G2 3, read: no,  style: comic english humour, price: 2}
   - {title: H2G2 4, read: no,  style: comic english humour, price: 2}
 

Aldiss, Brian :
  helliconia:  
   - {title: Le printemps d''helliconia, read: no,  style: SF, price: 1}
   - {title: "Helliconia, l''ete", read: no,  style: SF, price: 1}
   - {title: L''hiver d''helliconia, read: no,  style: SF, price: 1}
  books:
   - {title: L''instant de l''eclipse, read: no,  style: fantaisie, price: 1}

sum : 8'
]

{ #category : #tests }
CCollectorEasyTest >> testExtractAuthor [

	| author |
	author := (CCollectorEasy new extractAuthor: ' Wilson  ').
	self assert: author name equals: 'Wilson'.
	self assert: author firstName equals: ''
]

{ #category : #tests }
CCollectorEasyTest >> testExtractAuthorWithFirstNames [

	| author |
	author := (CCollectorEasy new extractAuthor: ' Wilson  ,   Charles Robert ').
	self assert: author name equals: 'Wilson'.
	self assert: author firstName equals: 'Charles Robert'
]

{ #category : #tests }
CCollectorEasyTest >> testExtractBook [

	| book |
	book := (CCollectorEasy new extractBook: (PPYAMLGrammar parse: '{title : Les vents du changement, read : no, style : SF, price : 2.39} ')).
	
	self assert: book title equals: 'Les vents du changement'.
	self assert: book price equals: 2.39.
	self assert: book style equals: 'SF'.
	self deny: book read
	
]

{ #category : #tests }
CCollectorEasyTest >> testImport [

	| ce liconia |
	ce := CCollectorEasy new import: self minilist.
	self assert: ce importedItemSize  equals: 8.
	liconia := ce importedCollection items select: [ :each |  '*liconia*' match: each title  ].
	self assert: liconia size equals: 3.
	liconia do: [ :each | 
		self assert: ('*liconia*' match: each serie name)
		]
]

{ #category : #tests }
CCollectorEasyTest >> testImportAuthor [

	| ce liconia book1 |
	ce := CCollectorEasy new import: self minilist.
	self assert: ce importedItemSize  equals: 8.
	book1 := (ce importedCollection items select: [ :each | each title = 'Le printemps d''helliconia' ]) first.
	self assert: book1 authors size equals: 1.
]

{ #category : #'tests basic YAML' }
CCollectorEasyTest >> testNested [

	| dict |
	dict := PPYAMLGrammar parse:
'matrix:
  include:
    - os: osx
      env: ARCH="macos32x86" FLAVOR="pharo.cog.spur" SRC_ARCH="i386"
      after_deploy: 
        - ./scripts/deploy-after.sh
    - os: osx
      env: ARCH="macos64x64" FLAVOR="pharo.cog.spur" SRC_ARCH="x86_64"
  before_deploy: 
    - (cd scripts && sh ./deploy-key.sh)
    - ./scripts/deploy-before.sh
deploy:
  - provider: bintray
    skip_cleanup: true
    file: .bintray.json
    user: $BINTRAY_USER
    key: $BINTRAY_API_KEY
    on:
      branch: master
      repo: pharo-project/pharo-vm
'. 
	self assert: dict size equals: 2.
	self assert: ((dict at: 'matrix') at: 'include') size equals: 2. 
	self assert: (dict at: 'deploy') first size  equals: 6. "provider to on"
]

{ #category : #'tests basic YAML' }
CCollectorEasyTest >> testNestedUnnested [

	| dict |
	dict := PPYAMLGrammar parse:
'- matrix:
  include:
    - os: osx
      env: ARCH="macos32x86" FLAVOR="pharo.cog.spur" SRC_ARCH="i386"
      after_deploy: 
        - ./scripts/deploy-after.sh
    - os: osx
      env: ARCH="macos64x64" FLAVOR="pharo.cog.spur" SRC_ARCH="x86_64"
  before_deploy: 
    - (cd scripts && sh ./deploy-key.sh)
    - ./scripts/deploy-before.sh
- deploy:
  - provider: bintray
    skip_cleanup: true
    file: .bintray.json
    user: $BINTRAY_USER
    key: $BINTRAY_API_KEY
    on:
      branch: master
      repo: pharo-project/pharo-vm
- top level
'. 
	"to have a entry that is not a dictionary but just an item such as top level. 
	other elements should be in a sequence."
	
	self assert: dict size equals: 3 
]

{ #category : #'tests basic YAML' }
CCollectorEasyTest >> testSimpleAuthorSequences [

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
CCollectorEasyTest >> testSimpleAuthorValues [

	| dict |
	dict := PPYAMLGrammar parse:
'
Wilcon, Robert Charles: 
      - { title: Darwinia, one : two , three: four , }
      - Mysterium (lu une partie d''une ville est teleporte dans un monde parallele)
      - Spin (lu la terre mis dans un sachet)
Zelasny:
      - Les neuf princes d''ambre
'. 

	self assert: dict size equals: 2.
	self assert: (dict at: 'Wilcon, Robert Charles') size equals: 3

]

{ #category : #'tests basic YAML' }
CCollectorEasyTest >> testSimpleAuthorWithSeriesSequences [

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
CCollectorEasyTest >> testSimpleYAMLAuthor [

	| dict |
	dict := PPYAMLGrammar parse:
'author: Wilcon, Robert Charles '. 
	self assert: (dict at: 'author') equals: 'Wilcon, Robert Charles'
]

{ #category : #'tests basic YAML' }
CCollectorEasyTest >> testSimpleYAMLNoDoubleKeyAuthor [

	| dict |
	dict := PPYAMLGrammar parse:
'author: Wilcon, Robert Charles 

author: Zelazny'
. 
	self assert: (dict at: 'author') equals: 'Zelazny'
]

{ #category : #'tests basic YAML' }
CCollectorEasyTest >> testSimpleYAMLSequences [

	| dict |
	dict := PPYAMLGrammar parse:
'
- Darwinia (250)
- Mysterium (lu une partie d''une ville est teleporte dans un monde parallele)
- Spin (lu la terre mis dans un sachet)
'. 
	self assert: dict size equals: 3.

]
