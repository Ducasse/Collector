Class {
	#name : #BaselineOfCollector,
	#superclass : #BaselineOf,
	#category : #BaselineOfCollector
}

{ #category : #baselines }
BaselineOfCollector >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		"Dependency to YAML to be removed"
		spec
			baseline: 'PetitParser'
			with: [
					spec
						loads: #('YAMLCore');
						repository: 'github://moosetechnology/PetitParser:v2.2.0/src' ].
		spec
			baseline: 'Descent'
			with: [
					spec repository: 'github://Ducasse/Descent/' ].
		spec 
			package: 'Collector';
			package: 'Collector-Easy' with: [
				spec requires: #('Collector' #'PetitParser')];
			package: 'Collector-DLittle' with: [
				spec requires: #('Collector' #'Descent')].
		spec 
			group: 'default' with: #('Collector' 'Collector-Easy' 'Collector-DLittle') ]
]
