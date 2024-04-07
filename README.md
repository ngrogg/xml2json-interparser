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
Takes an input file, format, output file, format and output filepath as arguments. <br>
Usage, `./parser.pl inFile format outFile format /path/to/outfile` <br>
Ex. `./parser.pl inFile.xml xml outFile.json json ~/` <br>
Parsed files are saved by default to the output folder. <br>
Passing an output filepath overrides this setting. <br>
