# xml2json-interparser

## Overview
An in-progress Perl script for moving XML files to the JSON format or vice-versa.

### Requirements
Parser script requires the following modules: <br>
* JSON
* XML::Simple
* Switch

Packages can be installed with the cpan command: <br>
`cpan install JSON` <br>
`cpan install JSON::Validator` <br>
`cpan install Switch` <br>
`cpan install XML:LibXML` <br>
`cpan install XML::Simple` <br>

## Usage
Takes an input file, it's format, and output file as arguments. <br>
Usage, `./parser.pl format inFile outFile /path/to/outputFolder` <br>
Ex. `./parser.pl xml inFile.xml outFile.json ~/Documents` <br>
Parsed files are saved by default to ~/. <br>
Passing an output filepath overrides this setting. <br>
Has checks for files and file validation. <br>
