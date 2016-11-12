#!/usr/bin/perl -w
use strict;

my $dir_list = shift;

open LIST,$dir_list or die $!;

while(<LIST>){
	chomp;
	next if /^#/;
	my ($name,$dir) = split /\s+/;
	#print "$dir\n";
	#print "genedock list $dir/\n";
	my $record = `genedock list $dir`;
	chomp $record;
	my @line = split /\s+/, (split /\n/,$record)[1];
	next if $line[2] eq "0B";
	print "$name\t$dir/$line[-1]\n";
	my $old_file = "$dir/$line[-1]";
	my $new_file = "$name.$line[-1]";
	#my $file_name = (split /\s+/,(split /\n/,$file))[1];
	#NO.       STATUS         SIZE           CREATE_TIME              MODIFIED_TIME            NAME
	#1         available      169.40MB       2016-11-11 13:30:40      2016-11-11 13:30:40      randomcode4_storedata.gz
	#my $old_file = "test/$dir/randomcode4_storedata.gz";
	#print "$file_name\n";
	#print "$old_file\n";
	#my $new_file = "$name.blasx.gz";
	system("genedock download $old_file $new_file");
}
