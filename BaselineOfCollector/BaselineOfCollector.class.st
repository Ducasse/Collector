Class {
	#name : #BaselineOfCollector,
	#superclass : #BaselineOf,
	#category : #BaselineOfCollector
}

{ #category : #baselines }
BaselineOfCollector >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
		baseline: 'Teapot'
			with: [ spec
				repository: 'github://zeroflag/Teapot:master/source' ].	
		spec
			baseline: 'Descent'
			with: [
					spec repository: 'github://Ducasse/Descent/' ].
		spec 
			package: 'Collector';
			package: 'Collector-Server'
				with: [ spec requires: #('Collector' 'Teapot')] ;
			package: 'Collector-Book-DLittleImporter2' 
				with: [ spec requires: #('Collector' #'Descent')];
			package: 'Collector-Book-DLittleImporter' 
				with: [ spec requires: #('Collector' #'Descent')];
			package: 'Collector-Game-DLittleImporter' 
				with: [ spec requires: #('Collector' #'Descent')].
		spec 
			group: 'default' with: #('Collector' 'Collector-Server' 'Collector-Game-DLittleImporter' 'Collector-Book-DLittleImporter' 'Collector-Book-DLittleImporter2') ]
]
