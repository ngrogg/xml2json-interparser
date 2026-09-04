# xml2json-interparser

## Overview
An in-progress Perl script for moving XML files to the JSON format or vice-versa.

### Requirements
Parser script requires the following modules: <br>
* JSON
* XML::Simple
* XML:LibXML

## Usage
Takes an input file, it's format, and output file as arguments. <br>
Usage, `./parser.pl format inFile outFile /path/to/outputFolder` <br>
Ex. `./parser.pl xml inFile.xml outFile.json ~/Documents` <br>
Parsed files are saved by default to ~/. <br>
Passing an output filepath overrides this setting. <br>
Has checks for files and file validation. <br>
<br>
There are sample JSON and XML files located in the sampleInput folder.
