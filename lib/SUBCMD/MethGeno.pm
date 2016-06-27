package SUBCMD::MethGeno;

use strict;
use warnings;
use File::Basename;
use FindBin;
use Pod::Usage;
use Cwd qw(abs_path);

## class, $opts, $opts_sub
sub new{
    my $class     = shift;
    return bless {}, $class;  # built in bless function 
}

sub check_para_sub{

    my ($class, $opts_sub, $opts) = @_;

    if($opts->{help}){
        pod2usage(-exitval => 1, -verbose => 2, -input => "$FindBin::Bin/doc/pod4help_MethGeno.txt");
        exit 0;
    }

    if(!&check_para($class, $opts_sub)){
        print "Please provide parameters\n";
        pod2usage(-exitval => 1, -verbose => 2, -input => "$FindBin::Bin/doc/pod4help_MethGeno.txt");
        exit 0;
    }

    my $exit_code = 0;
    if(!$opts_sub->{"genome"}){
        print "Please provide --genome!!!\n";
        ++$exit_code; #exit 0;
    }else{
       $opts_sub->{"project_dir"} = abs_path $opts_sub->{"project_dir"};
       if(-e "$opts_sub->{project_dir}.fai"){
	    print "No fai file was found\n\nPlease use samtools to generate the fai file.\n";
	    ++$exit_code;
       }else{
	    print "Genome fai detected.\n";
       }
    }

    # window size 
    if(!$opts_sub->{"win"}){
        $opts_sub->{"win"} = 500000;
    }
   
    # step size
    if(!$opts_sub->{"step"}){
        $opts_sub->{"step"} = 500000;
    }
    
    if(!$opts_sub->{"stetp"}){
        $opts_sub->{"step"} = 500000;
    }
    if(!$opts_sub->{"queue"}){
        $opts_sub->{"queue"} = "bioinf-b";
        print "You don't provide queue in the command line.\n";
        print "I'm going to use default queue which is bioinf-b\n";
    }
    #
    if(!$opts_sub->{"walltime"}){
        $opts_sub->{"walltime"} = "186:00:00";
        print "You don't provide walltime in the command line.\n";
        print "I'm going to use default walltime which is 186:00:00\n";
    }else{
        if($opts_sub->{"walltime"} !~ /\d+:\d{2}:\d{2}/){
            print "--walltime: $opts_sub->{walltime}\n";
            print "Please provide your walltime in this format: 186:00:00 [hh:mm:ss]\n";
            ++$exit_code; #exit 0;
        }
    }

    #core_num
    if(!$opts_sub->{"core_num"}){
            $opts_sub->{"core_num"} = 1;
    }

    # lib_type
    if(!$opts_sub->{"lib_type"}){
            $opts_sub->{"lib_type"} = "PE";
    }
    #references
    if(! $opts_sub->{"reference"}){
            print "\nPlease provide --reference!!!\n";
            print "Check error\n\n";
            ++$exit_code; #exit 0;
    }else{
            $opts_sub->{"reference"} = abs_path $opts_sub->{"reference"};
            #print "check Exists\t$opts_sub->{reference}\n";
    }

    # Set wether to send mail or not.
    if($opts_sub->{"mail"}){
        if($opts_sub->{"mail"} eq "OFF"){
            $opts_sub->{"mail"} = "#";
        }elsif($opts_sub->{"mail"} eq "ON"){
            $opts_sub->{"mail"} = "";
        }else{
            print "\nPlease provide --mail ON or OFF!!!\nDefault is ON\n";
            print "Check error\n\n";
            ++$exit_code; #exit 0;
        }
    }else{
        $opts_sub->{"mail"} = "";
    }

    if(!$opts_sub->{"debug"}){
        $opts_sub->{"debug"} = 0;
    }

    if($exit_code > 0){
        exit 0;
    }else{
	return "TRUE";
    }
}

sub check_para{
    my ($class, $opts) = @_;
    my $def = 0;
    my $num = 0;
    foreach(values %$opts){
        if(defined $_){
            $def ++;
        }
        ++$num;
    }
    if($def == 0){
        return 0;   ## No parameter was provide!
    }else{
        return 1;
    }
}


sub run_onestop{
    
    my ($class, $opts_sub, $opts) = @_;
    
    #create the directory for 

}

1;
