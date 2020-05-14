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
			baseline: 'Descent'
			with: [
					spec repository: 'github://Ducasse/Descent/' ].
		spec 
			package: 'Collector';
			package: 'Collector-Book-DLittleImporter' with: 
				[ spec requires: #('Collector' #'Descent')];
			package: 'Collector-Game-DLittleImporter' with: 
				[ spec requires: #('Collector' #'Descent')].
		spec 
			group: 'default' with: #('Collector' 'Collector-Game-DLittleImporter' 'Collector-Book-DLittleImporter' ) ]
]
