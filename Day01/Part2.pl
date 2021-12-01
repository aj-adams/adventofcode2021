use strict;
use warnings;

use Path::Tiny;
use List::Util qw(sum);
use autodie; # die if problem reading or writing a file

my $dir = path("./"); # examples in current dir

my $file = $dir->child("input.txt");

# Read in the entire contents of a file
# my $content = $file->slurp_utf8();

# openr_utf8() returns an IO::File object to read from
# with a UTF-8 decoding layer
my $file_handle = $file->openr_utf8();

# Read in line at a time
my @windows;
my $last_measure = 0;
my $measure = 0;
my $increases = 0;
while( my $depth = $file_handle->getline() ) {
	push @windows, $depth;
	if (3 == scalar @windows) {
		$measure = sum @windows;
		$increases++ if $measure > $last_measure;
		$last_measure = $measure;
		shift @windows;
	}
}

print $increases - 1; # Subtract one to account for the first window being counted as increased over nothing