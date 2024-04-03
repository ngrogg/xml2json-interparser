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

    ## TODO: Help output
}

# XML to JSON function
sub xmlToJson {
    print "XML -> JSON";
	print "----------------------------------------------------\n";

    ## Read passed values
    my ($command,$inputFile,$outputFile) = @_;

    ## TODO: Validation

    ## TODO: Parse XML to JSON

}

# JSON to XML function
sub jsonToXml {
    print "JSON -> XML";
	print "----------------------------------------------------\n";

    ## Read passed values
    my ($command,$inputFile,$outputFile) = @_;

    ## TODO: Validation

    ## TODO: Parse JSON to XML
}

# Function to run program
sub runProgram {
	print "XML To JSON interparser\n";
	print "----------------------------------------------------\n";

    ## Parse passed arguments
    my ($option,$file1,$file2) = @ARGV;

    ## Take action depending on passed arguments
    switch($option) {
        ### If $option == 'help' run help function and exit
        case "help" {
                helpFunction();
                exit 0;
        }
        ### If input XML and output JSON, run XML -> JSON function
        case "xml" {
                xmlToJson($option,$file1,$file2);
                exit 0;
        }
        ### If input JSON and output JSON, run JSON to XML function
        case "json" {
                jsonToXml($option,$file1,$file2);
                exit 0;
        }
        ### Else invalid options passed, run help function and exit
        else {
                print "Invalid option passed, running help function and exiting!";
                helpFunction();
                exit 1;
        }
    }
}

# Run the function
runProgram();
