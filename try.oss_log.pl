#!/usr/bin/perl -w
use strict;
use JSON;
use Data::Dumper;
use Encode;
use List::Util qw(min max);

# sub getmem
sub getmem(){
    my($jobid) = @_;
    my $max_mem;
    my $osscmd = "../bin/ossapi/osscmd";
#    print "$osscmd list oss://compute-system-beijing/$jobid/\n";
    my $osscmd_list = `$osscmd list oss://compute-system-beijing/$jobid/`;
#../bin/ossapi/osscmd list oss://compute-system-beijing/57fdab5e534680000151cd5f/
    my @osscmd_list = split /\n+/,$osscmd_list;
    my $metrics;
    foreach my $file(@osscmd_list){
        if($file=~/(oss\S+metrics.txt)/){

            $metrics = $1;
            last;
        }
    }
    `$osscmd get $metrics $jobid.metrics.txt`;
#    print "$osscmd get $metrics $jobid.metrics.txt\n";
 #   print "读取json数据...\n";
    my $json = new JSON;
    my $js;
    if(open(Myfile,"$jobid.metrics.txt")){
  #      print "打开json数据成功\n";
        my @mem;
        while(<Myfile>){
            next if /^\s+/;
            my $decoded_json = decode_json($_);
#            print Dumper($decoded_json)."\n";
            push @mem,$decoded_json->{'memory_stats'}->{'max_usage'};
#            print "Memory: ", $decoded_json->{'memory_stats'}->{'max_usage'},"\n";
#            last;
        }
        my $max_mem = max @mem;
        print "$jobid max_mem $max_mem\n";
    }else{
        die("打开json数据失败！！！！！！");
    }
    $max_mem;
}

## open LIST
my $list = shift;
open LIST,$list or die $!;
while(<LIST>){
    chomp;
    my ($name,$jobid) = split /\s+/,$_;
    print "$name\t";
    &getmem("$jobid");
}



#my @jobid = qw/57fdab5e534680000151cd5f /
#&getmem("57fdab5e534680000151cd5f");
