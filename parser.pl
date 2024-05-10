#!/usr/bin/perl
use Switch;
#use feature qw(switch);
use warnings;
use strict;
use JSON;
use JSON::Validator;
use XML::Simple;
use XML::LibXML;

# xml2json-interparser
# Move XML and JSON files between formatting
# By Nicholas Grogg

# Help
sub helpFunction {
    print "Help\n";
	print "----------------------------------------------------\n";
    print "XML 2 JSON Interparser";
    print "Move XML and JSON files between formats";
    print "Takes a format to convert to, an input file, output file and destination path as arguments";
    print "If no output path is provided default ~/";
    print "Usage. ./parser.pl format inFile outFile /path/to/outputFolder";
    print "Ex. ./parserl.pl xml input.xml output.json /home/jsmith/Documents";
}

# XML File Validator, checks that provided XML files is valid
sub xmlValidation{
        ## Assign passed XML file to variable
        my ($xmlFile) = @_;

        ## Create XML Parser object
        my $parser = XML::LibXML->new();

        # Validate XML file
        eval{
                my $validator = $parser->parse_file($xmlFile);
        };

        # If validator returns false, return 0
        if ($@){
                return 0;
        }
        # Else return 1
        else {
                return 1;
        }
}

# JSON File Validator, checks that provided JSON file is valid
sub jsonValidation{
        # Assign passed JSON file to variable
        my ($jsonFile) = @_;

        ## Create JSON Validator object
        my $validator = JSON::Validator->new();

        ## Validate JSON file
        eval {
                $validator->validate($jsonFile);
        };

        ## If validator returns false, return 0
        if($@){
                return 0;
        }
        ## Else return 1
        else{
                return 1;
        }
}

# XML to JSON function
sub xmlToJson {
    print "XML -> JSON\n";
	print "----------------------------------------------------\n";

    ## Read passed values
    #TODO: is $command needed?
    #my ($command,$inputFile,$outputFile,$outputFilePath) = @_;
    my ($command,$inputFile,$outputFile,$outputFilePath) = @_;

    #TODO: Validation
    ### Is outputFilePath null? If null use default, else use provided filepath
    ### Is inputFile null?
    ### Is outputFile null?
    ### Is provided XML file valid?
    xmlValidation($outputFile);

    #TODO: Parse XML to JSON

}

# JSON to XML function
sub jsonToXml {
    print "JSON -> XML\n";
	print "----------------------------------------------------\n";

    ## Read passed values
    #TODO: Is $command needed?
    #my ($command,$inputFile,$outputFile,$outputFilePath) = @_;
    my ($inputFile,$outputFile,$outputFilePath) = @_;

    #TODO: Validation
    ### Is outputFilePath null? If null use default, else use provided filepath
    ### Is inputFile null?
    ### Is outputFile null?
    ### Is provided JSON files valid?
    jsonValidation($inputFile);

    #TODO: Parse JSON to XML
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
                #TODO: Do I need $option?
                #xmlToJson($option,$file1,$file2,$outFilePath);
                xmlToJson($file1,$file2,$outFilePath);
                exit 0;
        }
        ### If input JSON and output JSON, run JSON to XML function
        #when ("json") {
        case "json" {
                #TODO: Do I need $option?
                #jsonToXml($option,$file1,$file2,$outFilePath);
                jsonToXml($file1,$file2,$outFilePath);
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
