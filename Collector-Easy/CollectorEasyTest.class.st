Class {
	#name : #CollectorEasyTest,
	#superclass : #TestCase,
	#category : #'Collector-Easy'
}

{ #category : #resources }
CollectorEasyTest >> minilist [

	^ 'Adam, Douglas : 
  books: 
   - Le guide du voyageur inter-galactique (lu delirant)
   - H2G2 4 2 euros
   - H2G2 3 2 euros
   - H2G2 2 2 euros


Aldiss, Brian :
  books: 
   - Le printemps d''helliconia 1 euos
   - Helliconia, l''ete 1 euros
   - L''hiver d''helliconia 1 euros
   - L''instant de l''eclipse


Ayerdhal:
   - l''Histrion 1 euros


Asimov, Isaac :  
  books : 
   - Un défilé de robots (lu longtemps)
   - La voie martienne (lu longtemps)
   - Les robots et l''empire I,
   - Les robots et l''empire II (lu longtemps)
   - Les cavernes d''acier (lu longtemps)
   - Les courants de l''espace 
   - Les dieux eux-memes
   - DESTINATION CERVEAU 2.69
   - Légende 
   - L''avenir commence demain
   - Les vents du changement 2,39
   - nemesis 2,69
   - le voyage fantastique 2,39
  foundation: 
   - Fondation
   - Second fondation 2,69
   - Fondation et empire
   - Fondation foudroyée


Anderson, Poul : 
  books : 
   - la reine de l''air et des tenebres 2.3
   - la patrouille du temps 2.3 
   - la route etoilee 2.3 
   - Tau Zero 2 Euros

sum : 30'
]

{ #category : #resources }
CollectorEasyTest >> testImport [

	| ce |
	ce := CollectorEasy new 
	
				import: self minilist.
	
	self assert: ce collection 
]

{ #category : #'tests basic YAML' }
CollectorEasyTest >> testNested [

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
CollectorEasyTest >> testNestedUnnested [

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
