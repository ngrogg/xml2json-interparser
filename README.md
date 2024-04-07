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
`cpan install XML::Simple` <br>
`cpan install Switch` <br>

## Usage
Takes an input file, it's format, and output file as arguments. <br>
Usage, `./parser.pl format inFile outFile /path/to/outputFolder` <br>
Ex. `./parser.pl xml inFile.xml outFile.json ~/` <br>
Parsed files are saved by default to the output folder. <br>
Passing an output filepath overrides this setting. <br>
