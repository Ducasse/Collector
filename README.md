# Collector
To manage simple collections using (YAML to be deprecated) and DLittle (a little and lovely lispish description language).

[![Build Status](https://travis-ci.com/Ducasse/Collector.svg?branch=master)](https://travis-ci.com/Ducasse/Collector)
[![Coverage Status](https://coveralls.io/repos/github/Ducasse/Collector/badge.svg?branch=master)](https://coveralls.io/github/Ducasse/Collector?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/Ducasse/Collector/master/LICENSE)
[![Pharo version](https://img.shields.io/badge/Pharo-8.0-%23aac9ff.svg)](https://pharo.org/download)


Here is a sample of a possible data.

```
(author : Aldiss / Brian 
  (serie : helliconia  
  	(title: Le printemps d''helliconia (read: no)  (style: SF) (price: 1))
  	(title: Helliconia, l''ete (read: no)  (style: SF) (price: 1))
 	(title: L''hiver d''helliconia (read: no)  (style: SF) (price: 1))
  (books : individual
    	(title: L''instant de l''eclipse (read: no)  (style: fantaisie) (price: 1))
 ```     
      
## Installation

To install the packages of Collector, go to the Playground (Ctrl+OW) in your Pharo image and execute the following Metacello script (select it and press Do-it button or Ctrl+D):

```Smalltalk
Metacello new
  baseline: 'Collector';
  repository: 'github://Ducasse/Collector/src'
```
