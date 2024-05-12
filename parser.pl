#!/usr/bin/perl
use warnings;
use strict;
use JSON;
use JSON::Validator;
use Switch;
#use feature qw(switch);
use XML::Simple;
use XML::LibXML;

# xml2json-interparser
# Move XML and JSON files between formatting
# By Nicholas Grogg
# TODO: Clean up commented out code

# Help
sub helpFunction {
    print "Help\n";
	print "----------------------------------------------------\n";
    print "XML 2 JSON Interparser\n";
    print "Move XML and JSON files between formats\n";
    print "Takes a format to convert to, an input file, output file and destination path as arguments\n";
    print "If no output path is provided default ~/\n";
    print "Usage. ./parser.pl format inFile outFile /path/to/outputFolder\n";
    print "Ex. ./parserl.pl xml input.xml output.json /home/jsmith/Documents\n";
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
    my ($inputFile,$outputFile,$outputFilePath) = @_;

    ## Validation
    ### Is inputFile null?
    if (not defined $inputFile){
        print "ISSUE DETECTED: An input filename was not found!\n";
	    print "----------------------------------------------------\n";
        print "Re-run script with valid values. \n";
        exit 1;
    }
    else {
        print "Input filename was defined\n";
	    print "----------------------------------------------------\n";
        print "Proceeding\n";
    }

    ### Is outputFile null?
    if (not defined $outputFile){
        print "ISSUE DETECTED: An output filename was not found!\n";
	    print "----------------------------------------------------\n";
        print "Re-run script with valid values. \n";
        exit 1;
    }
    else {
        print "Output Filename was defined\n";
	    print "----------------------------------------------------\n";
        print "Proceeding\n";
    }

    ### Is outputFilePath null? If null use default, else use provided filepath
    if (not defined $outputFilePath){
        print "IMPORTANT: Filepath for output file undefined!\n";
	    print "----------------------------------------------------\n";
        print "Defaulting to ~/\n";
        print "Press enter to proceed or control-c to quit\n";
        my $junkInput = <STDIN>;
    }
    else {
        print "Output Filepath was defined\n";
	    print "----------------------------------------------------\n";
        print "Proceeding\n";
    }

    ### Is provided XML file valid?
    if (xmlValidation($outputFile)){
            print "XML input file valid, continuing.\n";
    }
    else {
            print "ISSUE DETECTED: XML input file failed to validate!\n";
	        print "----------------------------------------------------\n";
            print "Verify XML file and re-run script!\n";
            exit 1;
    }

    ## Parse XML to JSON
    ### Create XML items
    my $xmlInput   = $inputFile;
    my $jsonOutput = $outputFile

    ### Read in XML files
    open my $xmlRead, '<', $xmlInput or die "Unable to open $inputFile: $!";
    my $xmlText    = do { local $/; <$xmlRead> };
    close $xmlRead;

    ### Convert XML Data to Perl data structure
    my $xmlData    = XMLin($xmlText);

    ### Convert Perl data structure to JSON data
    my jsonText    = to_json($xmlData, { pretty => 1});

    ### Write JSON data to file
    open my $jsonWrite, '>', $jsonOutput or die "Unable to open $jsonOutput: $!";
    print $jsonWrite $jsonText;
    close $jsonWrite;

}

# JSON to XML function
sub jsonToXml {
    print "JSON -> XML\n";
	print "----------------------------------------------------\n";

    ## Read passed values
    #TODO: Is $command needed?
    #my ($command,$inputFile,$outputFile,$outputFilePath) = @_;
    my ($inputFile,$outputFile,$outputFilePath) = @_;

    ## Validation
    ### Is inputFile null?
    if (not defined $inputFile){
        print "ISSUE DETECTED: An input filename was not found!\n";
	    print "----------------------------------------------------\n";
        print "Re-run script with valid values. \n";
        exit 1;
    }
    else {
        print "Input filename was defined\n";
	    print "----------------------------------------------------\n";
        print "Proceeding\n";
    }

    ### Is outputFile null?
    if (not defined $outputFile){
        print "ISSUE DETECTED: An output filename was not found!\n";
	    print "----------------------------------------------------\n";
        print "Re-run script with valid values. \n";
        exit 1;
    }
    else {
        print "Output Filename was defined\n";
	    print "----------------------------------------------------\n";
        print "Proceeding\n";
    }

    ### Is outputFilePath null? If null use default, else use provided filepath
    if (not defined $outputFilePath){
        print "IMPORTANT: Filepath for output file undefined!\n";
	    print "----------------------------------------------------\n";
        print "Defaulting to ~/\n";
        print "Press enter to proceed or control-c to quit\n";
        my $junkInput = <STDIN>;
    }
    else {
        print "Output Filepath was defined\n";
	    print "----------------------------------------------------\n";
        print "Proceeding\n";
    }


    ### Is provided JSON file valid?
    if (jsonValidation($inputFile)){
            print "JSON input file valid, continuing.\n";
    }
    else {
            print "ISSUE DETECTED: JSON input file failed to validate!\n";
	        print "----------------------------------------------------\n";
            print "Verify JSON file and re-run script!\n";
            exit 1;
    }

    ## Parse JSON to XML
    ### Create JSON items
    my $jsonInput = $inputFile;
    my $xmlOutput = $outputFile;

    ### Read in JSON files
    open my $jsonRead, '<', $jsonInput or die "Unable to open $jsonInput: $!";
    my $jsonData  = do { local $/; <$jsonRead> };
    close $jsonRead;

    ### Convert JSON data to Perl data structure
    my $perlData  = decode_json($jsonData);

    ### Convert Perl data structure to XML
    my $xmlData   = XMLout($perlData, Rootname => 'root', XMLDecl => 1);

    ### Write XML to file
    open my $xmlWrite, '>', $xmlOutput or die "Unable to open $xmlOutput: $!";
    print $xmlWrite $xmlData;
    close $xmlWrite;

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
        ### If input JSON and output XML, run JSON to XML function
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
