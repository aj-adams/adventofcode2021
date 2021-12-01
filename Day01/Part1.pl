use strict;
use warnings;

use Path::Tiny;
use autodie; # die if problem reading or writing a file

my $dir = path("./"); # examples in current dir

my $file = $dir->child("input.txt");

# Read in the entire contents of a file
# my $content = $file->slurp_utf8();

# openr_utf8() returns an IO::File object to read from
# with a UTF-8 decoding layer
my $file_handle = $file->openr_utf8();

# Read in line at a time
my $last_line = $file_handle->getline();
my $increases = 0;
while( my $line = $file_handle->getline() ) {
	$increases++ if $line > $last_line;
	$last_line = $line;
}

print $increases;