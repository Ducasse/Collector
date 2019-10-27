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
			baseline: 'PetitParser'
			with: [
					spec
						loads: #('YAMLCore');
						repository: 'github://moosetechnology/PetitParser/:v2.2.0/src'
		].
		spec 
			package: 'Collector';
			package: 'Collector-Easy' with: [
				spec requires: #('Collector' #'PetitParser')].
		spec 
			group: 'default' with: #('Collector' 'Collector-Easy') ]
]
