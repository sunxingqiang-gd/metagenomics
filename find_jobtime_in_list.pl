#!/usr/bin/perl -w
use strict;

my $list = shift;
open LIST,$list or die $!;
my $header1 = <LIST>;
my $header2 = <LIST>;
print "|software|seq_name|db_name|job_id|run_time(min)|\n";
print "|---|---|---|---|---|\n";
#print "software\tseq_name\tdb_name\tjob_id\trun_time(min)\n";
while(<LIST>){
    chomp;
    my @line = split /\|/,$_;
    my $software = $line[1];
    my $seq_name = $line[2];
    my $db_name = $line[3];
    my $job_id = $line[$#line];
    next if $job_id=~/-/;
    my $log = `gdtools task getjobs -i $job_id|grep run_time`;
    chomp $log;
    $log =~s/\s//g;
    $log =~s/run_time\(min\)://g;
    #print "$software\t$seq_name\t$db_name\t$job_id\$log\n";
    print "|$software|$seq_name|$db_name|$job_id|$log|\n";
    
}
