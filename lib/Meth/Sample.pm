package Meth::Sample;
use strict;
use warnings;
use File::Basename;
use FindBin;
use Pod::Usage;
use Cwd qw(abs_path);

my %rec_geno_len;
my $SAMPLELIST = "sample_list";
sub new{
    my $class     = shift;
    return bless {}, $class;  # built in bless function
}

sub processArgvSampleGenome{
   my ($class, $opts_sub) = @_;
   #print "$opts_sub\t", keys %$opts_sub, "\n";
   my @sample = @{$opts_sub->{sample}};
   if(join("", @sample) !~ /file:/){
	foreach my $sam(@sample){
	     my ($meth_file, $sam_name) = split(/,/, $sam);
	     push @{$opts_sub -> {$SAMPLELIST}}, $sam;
        }
   }else{
	if(@sample > 0){
	    print "Only sample should be provided if you use a TEXT file to provide the sample information.\n";
	    exit 0;
        }else{
	    $sample[0] =~s/file://;
	    open SAM, $sample[0] or die "$!";
	    while( my $line = <SAM>){
		next if /#/;
		print "$line";
		chomp $line;
		my ($meth_file, $sam_name) = split(/\s+/, $line);
		push @{$opts_sub -> {$SAMPLELIST}}, "$meth_file,$sam_name";
            }
	}
   }
   
}

1;

