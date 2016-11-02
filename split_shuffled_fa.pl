#!/usr/bin/perl -w
## 这个脚本是用来对数据库（fa文件）进行随机重排，并按照固定的序列条数进行切分。
## 需求内存小，速度快。
## user:sunxingqiang
#use strict;
use List::Util;
die "perl $0 <lines> <fa> <shuffle_time> <prefix>" unless $#ARGV==3;
# seqs per file
my $lines = shift;
my $fa = shift;
my $shuffle_time = shift;
my $prefix = shift;

#指定参考序列的条数信息
my $total_num = 316160;

my @total_num = 1..$total_num;
my @new_array = &shuffle(\@total_num,$shuffle_time);
my %hash_lines;
## generation shuffle numbers 切分数目
my $section_num = int(($#new_array+1)/$lines);
my $num = 1;

for (my $i=0;$i<=($section_num*$lines);$i=$i+$lines){

	if($num > $section_num){
        	my @final_lines = @new_array[($section_num*$lines)..$#new_array];
        	foreach my $key(@final_lines){
			$hash_lines{$key} = $num;
		}
		print "num:$num\tsection_num:$section_num\n";
		open OUTLIST,">$prefix.$num.num.list" or die $!;
		print OUTLIST "section_num:\t$num\n@final_lines\n";
                close OUTLIST;
		last;
        }
        my $end = $i+$lines-1;
        my @temp = @new_array[$i..$end];
        foreach my $key(@temp){
		$hash_lines{$key} = $num;
	}
	open OUTLIST,">$prefix.$num.num.list" or die $!;
	print OUTLIST "section_num:\t$num\n@temp\n";
        close OUTLIST;
        $num++;
}


my %seqs;
my $seq_num = 0;
my $count = 0;


#rm privous seq
foreach my $i(1..$num){
	if(-f "$prefix.$i.fa"){
		unlink "$prefix.$i.fa" or die $!;

	}
}
open FA,$fa or die $!;
while(<FA>){
	if(/>/){
  #每20000行的序列进行输出，一方面减少反复开启IO句柄，另一方面减少一次读入太多序列hash的内存压力
		if($count == 20000){
			foreach my $key(keys %seqs){
				#open OUT,">> $key" or die $!;
				open $key,">> $key" or die $!;
				print $key $seqs{$key};
				close $key

			}
			undef %seqs;
			$count = 0;
		}
	#	print "count $count\n";
		$count++;
		$seq_num++;
	}
	my $tags = $hash_lines{$seq_num};
	#print "$tags\n";
	$seqs{"$prefix.$tags.fa"} .=$_;
}
#出去20000切分后剩余的序列
if ($count >0 ){
	for my $key (keys %seqs) {
		open $key, ">> $key" || die $!;
		print $key $seqs{$key};
		close $key;
	}
}

### sub ###
sub shuffle(){
	my ($pre_array,$times) = @_;
        my @temp_array;
        foreach my $i(1..$times){
                @temp_array = List::Util::shuffle @$pre_array;
        }
        return @temp_array;
}
