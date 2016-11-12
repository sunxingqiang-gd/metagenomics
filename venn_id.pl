#!/usr/bin/perl
use warnings;
use strict;

my $venn_list = shift;

open IN,$venn_list or die $!;


while(<IN>){
	chomp;
	next if /#/;
	my @line = split /\s+/;
	my $name = $line[0];
	my $file_num = $#line;
	if ($file_num == 2){
	    ## 2 sample venn ##
	    my @item1 = &trans_blast2array($line[1]);
	    my @item2 = &trans_blast2array($line[2]);

	}elsif($file_num == 3){
	    ## 3 sample venn ##
	    my $item1 = &trans_blast2array($line[1]);
	    my $item2 = &trans_blast2array($line[2]);
	    my $item3 = &trans_blast2array($line[3]);
	    my $re1 = join "\",\"",@$item1;
	    $re1 = "blastx=c(\"$re1\")";
	    my $re2 = join "\",\"",@$item2;
	    $re2 = "blastx_fast=c(\"$re2\")";
	    my $re3 = join "\",\"",@$item3;
	    $re3 = "diamond_blastx=c(\"$re3\")";
            my $R_shell_file = "$name.venn.R";
	    open RSHELL,">$R_shell_file" or die $!;
            my $Rshell = <<R;
library("VennDiagram")
library(grid)
venn.plot <- venn.diagram(
     x = list(
     $re1,
     $re2,
     $re3),
     filename=NULL,
     main = "Venn plot",
     main.cex=2.5,
     col = "transparent",
     fill = c("red", "blue", "green"),
     alpha = 0.5,
     category.names=c("blastx","blast_fast","diamond_blastx"),
     label.col = c("darkred", "white", "darkblue", "white", "white", "white", "darkgreen"),
     cex = 2.0,
     fontfamily = "serif",
     fontface = "bold",
     cat.default.pos = "text",
     cat.col = c("darkred", "darkblue", "darkgreen"),
     cat.cex = 2.0,
     cat.fontfamily = "serif",
     cat.dist = c(0.06, 0.06, 0.03),
     cat.pos = 0
);
png("blastx_blastx-fast_diamond.venn.png",800,800)
grid.draw(venn.plot);
dev.off()
R
# R must in the head of code line 
             print RSHELL $Rshell;
	}elsif($file_num == 4){
	    ## 4 sample venn ##
	    
	}else{
	    die "the files not in 2~4.\n Please checke the list file\n";
	}

}
close IN;
 
sub trans_blast2array{
	my ($file) = @_;
	my %hash_query;
	open F,$file or die $!;
	while(<F>){
		my @line = split /\s+/;
		chomp;
		$hash_query{$line[0]} = 1;
	}
	my @query_id = keys %hash_query;
	close F;
	return \@query_id;
}
