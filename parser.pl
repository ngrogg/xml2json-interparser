#!/usr/bin/perl
use Switch;
#use feature qw(switch);
use warnings;
use strict;
use JSON;
use XML::Simple;

# xml2json-interparser
# Move XML and JSON files between formatting
# By Nicholas Grogg

# Help
sub helpFunction {
    print "Help\n";
	print "----------------------------------------------------\n";
    ## TODO: Help output
    }

# XML to JSON function
sub xmlToJson {
    print "XML -> JSON\n";
	print "----------------------------------------------------\n";

    ## Read passed values
    my ($command,$inputFile,$outputFile,$outputFilePath) = @_;

    ## TODO: Validation
    ### Is outputFilePath null? If null use default, else use provided filepath
    ### Is inputFile null?
    ### Is outputFile null?

    ## TODO: Parse XML to JSON

}

# JSON to XML function
sub jsonToXml {
    print "JSON -> XML\n";
	print "----------------------------------------------------\n";

    ## Read passed values
    my ($command,$inputFile,$outputFile,$outputFilePath) = @_;

    ## TODO: Validation
    ### Is outputFilePath null? If null use default, else use provided filepath
    ### Is inputFile null?
    ### Is outputFile null?

    ## TODO: Parse JSON to XML
}

# Function to run program
sub runProgram {
	print "XML To JSON interparser\n";
	print "----------------------------------------------------\n";

    ## Parse passed arguments
    my ($option,$file1,$file2,$outFilePath) = @ARGV;

    #TODO: Remove given/when statements
    ## Take action depending on passed arguments
    #given ($option) {
    switch($option) {
        ### If $option == 'help' run help function and exit
        #when ("help") {
        case "help" {
                helpFunction();
                exit 0;
        }
        ### If input XML and output JSON, run XML -> JSON function
        #when ("xml") {
        case "xml" {
                xmlToJson($option,$file1,$file2,$outFilePath);
                exit 0;
        }
        ### If input JSON and output JSON, run JSON to XML function
        #when ("json") {
        case "json" {
                jsonToXml($option,$file1,$file2,$outFilePath);
                exit 0;
        }
        ### Else invalid options passed, run help function and exit
        #default {
        else {
                print "Invalid option passed, running help function and exiting!\n";
                helpFunction();
                exit 1;
        }
    }
}

# Run the function
runProgram();
