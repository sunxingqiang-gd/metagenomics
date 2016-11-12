#!/usr/bin/perl -w
use strict;
use PerlIO::gzip;
my $file = shift;
if ($file=~/\.gz$/){
    open IN,"<:gzip",$file or die $!
}else{
    open IN,$file or die $!;

}

#my ($id,$hit_def,$query_id,$hit_info,$bit_score);
my ($id,$hit_def,$hit_info,$Hsp_align_len,$bit_score,$Hsp_identity);
#($bit_score,$Hsp_align_len) = ("null","null");
while(<IN>){
    # record begin
    if(/^<Iteration>/){
        $hit_info = "Hits found";
	($bit_score,$Hsp_align_len,$Hsp_identity) = ("null","null","null");
    }
    if (/>(.*?)<\/Iteration_query-ID/){
    	#$query_id = $1;
    }
    if (/Iteration_query-def/){
        />(.*?)flag/;
        $id = $1;
    }

    if (/Hsp_align-len/){
        />(.*?)</;
        $Hsp_align_len = $1;
    }

    if (/Hit_def/){
        />(.*?)</;
        $hit_def = $1;
    }
    if (/Hsp_bit-score/){
        />(.*?)</;
        $bit_score = $1;
    }
    
    if (/Hsp_identity/){
         />(.*?)</;
         $Hsp_identity = $1;
     }
    
    if (/Hsp_qseq/){
# $out3=100*$tmp/$out4;
# $out3=sprintf"%0.2f",$out3;
# $out5=$out4-$tmp-$out6;
         #print"$id\t$bit_score\n";
         #print"$out1t$out2t$out3t$out4t$out5t$out6t$out7t$out8t$out9t$out10t$out11t$out12n";
    }
    if(/Iteration_message/){
        />(.*?)</;
        if ($1 eq "No hits found"){
            $hit_info = $1;
        }else{
            $hit_info = "Hits found";
        }
    }
    # record end
    if(/^\<\/Iteration\>/){
        if($hit_info eq "Hits found"){
            print "$id\t$bit_score\t$Hsp_identity\t$Hsp_align_len\t$hit_info\n";
        #print "$id\t$hit_def\t$bit_score\t$hit_info\n";
        #print "$query_id\t$id\t$hit_info\n";
	}
    }
}

close IN;
