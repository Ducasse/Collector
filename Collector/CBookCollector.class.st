Class {
	#name : #CBookCollector,
	#superclass : #CCollector,
	#category : #'Collector-Core'
}

{ #category : #import }
CBookCollector class >> filename [
	^ 'Books'
]

{ #category : #examples }
CBookCollector class >> smallCollection [
	<sampleInstance>
	| collector item1 item2 |
	collector := self new.
	collector declareNewCollection: #owned.
	item1 := CGameItem finalFantasyX.
	collector add: item1 to: #owned.
	item2 := CGameItem new
		title: 'Final Fantasy XII';
		hasBox: false;
		quotation: 10;
		critics: 15.
	collector add: item2 to: #owned.
	^ collector
]

{ #category : #examples }
CBookCollector class >> smallCollection2 [
	<sampleInstance>
	| collector item1 item2 item3 |
	collector := self new.
	collector declareNewCollection: #owned.
	item1 := CGameItem finalFantasyX.
	collector add: item1 to: #owned.
	item2 := CGameItem new
		title: 'Dragon Quest VIII: Journey Of The Cursed King';
		hasBox: true;
		quotation: 10;
		critics: 18;
		setPS2.
	collector add: item2 to: #owned.
	item3 := CGameItem new
		title: 'Persona 3';
		hasBox: true;
		quotation: 20;
		critics: 18;
		setPS3.
	collector add: item3 to: #owned.
	^ collector
]
