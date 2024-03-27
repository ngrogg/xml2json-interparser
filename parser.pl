#!/usr/bin/perl
use warnings;
use strict;
use JSON;
use XML::Simple;

# xml2json-interparser
# Move XML and JSON files between formatting
# By Nicholas Grogg

# Help
sub helpFunction {
    print "Help";
	print "----------------------------------------------------\n";
}

# XML to JSON function
sub xmlToJson {
    print "XML -> JSON";
	print "----------------------------------------------------\n";
}

# JSON to XML function
sub jsonToXml {
    print "JSON -> XML";
	print "----------------------------------------------------\n";
}

# Function to run program
sub runProgram {
	print "XML To JSON interparser\n";
	print "----------------------------------------------------\n";

    ## Parse passed arguments

    ## Take action depending on passed arguments
    ### If $1 == 'help' run help function and exit
    ### If input XML and output JSON, run XML -> JSON function
    ### If input JSON and output JSON, run JSON to XML function
    ### Else invalid options passed, run help function and exit
}

# Run the function
runProgram();
