#!/usr/bin/env perl

# Generic Perl imports
use warnings;
use strict;

# Script specific imports
use File::Spec;
use JSON;
use XML::Simple;
use XML::LibXML;

# xml2json-interparser
# Perl script to move XML and JSON files between formatting
# By Nicholas Grogg

# Help
sub helpFunction {
    print "Help\n";
	print "----------------------------------------------------\n";
    print "XML 2 JSON Interparser\n";
    print "Move XML and JSON files between formats\n\n";
    print " \n";
    print "Usage:\n";
    print " ./parser.pl format inputFile outputFile [outputPath]\n\n";
    print " \n";
    print "Formats:\n";
    print " xml Convert XML to JSON\n";
    print " json Convert JSON to XML\n";
    print " help Display this help message\n\n";
    print " \n";
    print "Arguments:\n";
    print " format Conversion format\n";
    print " inputFile File to convert\n";
    print " outputFile Name of the converted file\n";
    print " outputPath Destination directory (default: \$HOME)\n\n";
    print " \n";
    print "Examples:\n";
    print " ./parser.pl xml input.xml output.json\n";
    print " ./parser.pl xml input.xml output.json /home/jsmith/Documents\n";
    print " ./parser.pl json input.json output.xml\n";
}
# Convert JSON boolean objects to Perl scalar values
sub normalizeJsonBooleans {
    my ($data) = @_;

    if (ref $data eq 'HASH') {
        for my $key (keys %{$data}) {
            $data->{$key} = normalizeJsonBooleans($data->{$key});
        }
    }
    elsif (ref $data eq 'ARRAY') {
        for my $index (0 .. $#{$data}) {
            $data->[$index] = normalizeJsonBooleans($data->[$index]);
        }
    }
    elsif (ref $data eq 'JSON::PP::Boolean') {
        return $data ? 1 : 0;
    }

    return $data;
}

# Validate common arguments
sub validateArguments {
    my ($inputFile, $outputFile) = @_;

    ## Check that an input filename was provided
    if (!defined $inputFile || $inputFile eq '') {
        die "ISSUE DETECTED: An input filename was not provided!\n";
    }

    ## Check that an output filename was provided
    if (!defined $outputFile || $outputFile eq '') {
        die "ISSUE DETECTED: An output filename was not provided!\n";
    }

    ## Check that the input file exists
    if (!-e $inputFile) {
        die "ISSUE DETECTED: Input file '$inputFile' does not exist!\n";
    }

    ## Check that the input file is readable
    if (!-r $inputFile) {
        die "ISSUE DETECTED: Input file '$inputFile' is not readable!\n";
    }
}


# Build output file path
sub buildOutputPath {
    my ($outputFile, $outputFilePath) = @_;

    ## If no output path was provided, use the user's home directory
    if (!defined $outputFilePath || $outputFilePath eq '') {
        $outputFilePath = $ENV{HOME};

        if (!defined $outputFilePath || $outputFilePath eq '') {
            die "ISSUE DETECTED: Unable to determine user's home directory!\n";
        }
    }

    ## Build the complete output path
    return File::Spec->catfile($outputFilePath, $outputFile);
}


# XML File Validator
# Checks whether the provided XML file can be parsed
sub xmlValidation {
    my ($xmlFile) = @_;

    ## Create XML parser object
    my $parser = XML::LibXML->new();

    ## Attempt to parse XML file
    eval {
        $parser->parse_file($xmlFile);
    };

    ## Return false if parsing failed
    if ($@) {
        return 0;
    }

    ## XML parsed successfully
    return 1;
}


# XML to JSON function
sub xmlToJson {
    print "XML -> JSON\n";
    print "----------------------------------------------------\n";

    ## Read passed values
    my ($inputFile, $outputFile, $outputFilePath) = @_;

    ## Validate common arguments
    validateArguments($inputFile, $outputFile);

    ## Validate XML input file
    if (xmlValidation($inputFile)) {
        print "XML input file is valid, continuing.\n";
    }
    else {
        die "ISSUE DETECTED: XML input file failed to validate!\n";
    }

    ## Build complete output path
    my $outputPath = buildOutputPath($outputFile, $outputFilePath);

    ## Read XML file
    open my $xmlRead, '<:encoding(UTF-8)', $inputFile
        or die "Unable to open $inputFile: $!";

    my $xmlText = do {
        local $/;
        <$xmlRead>;
    };

    close $xmlRead
        or die "Unable to close $inputFile: $!";

    ## Convert XML data to Perl data structure
    my $xmlData = XMLin($xmlText);

    ## Convert Perl data structure to JSON
    my $jsonText = to_json($xmlData, { pretty => 1 });

    ## Write JSON data to file
    open my $jsonWrite, '>:encoding(UTF-8)', $outputPath
        or die "Unable to open $outputPath: $!";

    print $jsonWrite $jsonText
        or die "Unable to write to $outputPath: $!";

    close $jsonWrite
        or die "Unable to close $outputPath: $!";

    print "Conversion complete.\n";
    print "Output: $outputPath\n";
}


# JSON to XML function
sub jsonToXml {
    print "JSON -> XML\n";
    print "----------------------------------------------------\n";

    ## Read passed values
    my ($inputFile, $outputFile, $outputFilePath) = @_;

    ## Validate common arguments
    validateArguments($inputFile, $outputFile);

    ## Build complete output path
    my $outputPath = buildOutputPath($outputFile, $outputFilePath);

    ## Read JSON file
    open my $jsonRead, '<:encoding(UTF-8)', $inputFile
        or die "Unable to open $inputFile: $!";

    my $jsonData = do {
        local $/;
        <$jsonRead>;
    };

    close $jsonRead
        or die "Unable to close $inputFile: $!";

    ## Convert JSON data to Perl data structure.
    ## decode_json() will throw an error if the JSON is invalid.
    my $perlData;

    eval {
        $perlData = decode_json($jsonData);
    };

    if ($@) {
        die "ISSUE DETECTED: JSON input file failed to validate!\n";
    }

    # Convert JSON boolean objects to Perl scalar values
    $perlData = normalizeJsonBooleans($perlData);

    ## Convert Perl data structure to XML
    my $xmlData = XMLout(
        $perlData,
        Rootname => 'root',
        XMLDecl  => 1
    );

    ## Write XML data to file
    open my $xmlWrite, '>:encoding(UTF-8)', $outputPath
        or die "Unable to open $outputPath: $!";

    print $xmlWrite $xmlData
        or die "Unable to write to $outputPath: $!";

    close $xmlWrite
        or die "Unable to close $outputPath: $!";

    print "Conversion complete.\n";
    print "Output: $outputPath\n";
}


# Function to run program
sub runProgram {
    print "XML To JSON interparser\n";
    print "----------------------------------------------------\n";

    ## Parse passed arguments
    my ($option, $file1, $file2, $outFilePath) = @ARGV;

    ## Display help if no option was provided
    if (!defined $option) {
        helpFunction();
        exit 1;
    }

    ## Take action depending on passed arguments
    if ($option eq 'help') {
        helpFunction();
        exit 0;
    }
    elsif ($option eq 'xml') {
        xmlToJson($file1, $file2, $outFilePath);
    }
    elsif ($option eq 'json') {
        jsonToXml($file1, $file2, $outFilePath);
    }
    else {
        print "Invalid option '$option' passed.\n\n";
        helpFunction();
        exit 1;
    }
}

# Run the function
runProgram();
