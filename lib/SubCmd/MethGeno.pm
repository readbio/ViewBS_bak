package SubCmd::MethGeno;

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
       $opts_sub->{"genome"} = abs_path $opts_sub->{"genome"};
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

    if(!$opts_sub->{"context"}){
        $opts_sub->{"context"} = "CpG";
    }

    #core_num
    if(!$opts_sub->{"core_num"}){
            $opts_sub->{"core_num"} = 1;
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
