package Meth::Geno;


use strict;
use warnings;
use File::Basename;
use FindBin;
use Pod::Usage;
use Cwd qw(abs_path);


sub new{
    my $class     = shift;
    return bless {}, $class;  # built in bless function
}



1;

