#!/usr/bin/perl -w

############################################################
#                                                          #
#                                                          
#                                                          #
############################################################

use strict;
use Getopt::Long::Subcommand;
use Pod::Usage;
use File::Basename;
use Cwd qw(abs_path);
#use FindBin;
#use lib "$FindBin::Bin";

#Self written libraries.


$| = 1; # Do not buffer output 

## Package written by Shanshan Huang
use lib dirname(abs_path $0) . '/lib';  #include seft written packages in @INC. 
my $main_path = dirname(abs_path $0);

my %opts;   ##

### Return hash structure, with these keys: success, subcommand (array of str) by GetOptions
my $resOpt = &processCMD();

&check_parameter();
my %opts_subcmd;
sub check_parameter{
     
    # check if there is a subcommand given.
    pod2usage(-exitval => 1, -verbose => 2, -input => "$main_path/doc/doc4main_help.txt") if (!exists $resOpt->{"subcommand"});

    #get the subcommand name success and subcommand
    my ($sub_cmd) = @{$resOpt->{"subcommand"}}; 
    print "Subcommand: $sub_cmd\n";

    if($sub_cmd eq "MethGeno"){
	#print "Keys: ", join("\t", keys %opts_onestop), "\n";
        #print "Vals: ", join("\t", values %opts_onestop), "\n";
	#&check_para_onestopsd();
	my $check_para = SubCmd::MethGeno -> new();
	#print %opts_onestop, "\n";
	my $status = $check_para -> check_para_sub(\%opts_subcmd, \%opts);
        if($status){
	    #$check_para -> run_onestop(\%opts_sub);
        }
        
    }
}

sub processCMD{
    $resOpt = GetOptions(   # Return hash structure, with these keys: success, subcommand (array of str)

        ## common options recognized by all subcommands
        options => {
	    'help|h|?'  => \$opts{help},
	    'version|v' => \$opts{version}
         },
         subcommands => {
             MethGeno => {       
                 summary => 'Plot methylation information across the chromsome.',
                 # subcommand-specific options
                 options => {
        	    'genomeLength|g:s'       => \$opts_subcmd{genomeLength},
		    'win:i'                  => \$opts_subcmd{win},
                    'step:i'                 => \$opts_subcmd{step},       
		    'minLength:s'            => \$opts_subcmd{minLength},  # cutoff for minimum length of chromosome.
		    'split:!'                => \$opts_subcmd{split},      # 
		    'sample'                 => \@{$opts_subcmd{sample}},  # 
		    'type'                   => \$opts_subcmd{type},       # type of input files: 
		    'context'		     => \$opts_subcmd{context},    # context
                 }
             },
        }
    );
}

