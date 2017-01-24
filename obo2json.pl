#!/usr/bin/perl -w
use strict;

my $file = shift;
my $root_obo = shift;
open IN,$file or die $!;

my $flag = 1;
$/ = "[Term]";
my %obo_hash;
my ($key,$name,$def);
my $n = 1;
while(<IN>){
    $n++;
    #last if $n == 10;
    my @line = split /\n+/;
    my $flag = 0;
    foreach my $line(@line){
        chomp;
        if($line=~/id: (.*)/){
	    $key = $1;
	    $flag++;
	}
	if($line=~/name: (.*)/){
	    $name = $1;
	    $obo_hash{$key}{"name"} = $name;
	    $flag++;
	}
	if($line=~/def: (.*)\[/){
	    chomp;
	    if($key){
	        $def = $1;
	        $obo_hash{$key}{"def"} = $def;
		$flag++;
	    }
	}
	if($flag==3 and $line=~/is_a: (.*)\s+\!/){
	    chomp;
	    my $is_a = $1;
            $obo_hash{$key}{"parent"} .= "$is_a ";
	    $obo_hash{$is_a}{"child"} .= "$key ";
#	    print "id: $key\tis_a: $is_a\n";
	}
    }


}

close IN;

my $nodes_obo;
#print "Root_OBO:$root_obo\tchild:$obo_hash{$root_obo}{child}\n";
my $pre_json = <<PERJSON;
{
    "showRoot": false,
    "version": "2015-02-13",
    "rootNode": "$root_obo",
    "type": "ontology",
    "name": "biome",
    "nodes": {
PERJSON
print "$pre_json";
#my $root_obo = "ENVO:00000447";
my $sub_root_obo = &get_child_obo($root_obo,\%obo_hash);
#my $result = &get_child_obo('root',\%hash);
#print "$result\n";
my $end_json =<<ENDJSON;
    }
}
ENDJSON
print $end_json;

### sub ###
sub get_child_obo{
    my ($obo_id,$tmp_hash) = @_;
    my $child;
    my %obo_hash = %$tmp_hash;
    unless(exists $obo_hash{$obo_id}{child}){
        $child = "";
       	my @child = split /\s/,$child;
	my $parent = $obo_hash{$obo_id}{parent};
	my $child_json = "\"".join ("\",\"",@child)."\"";
	my @parent = split /\s/,$parent;
	my $parent_json = "\"".join ("\",\"",@parent)."\"";
        my $json_hash =<<HASH_JSON1;
	"$obo_id": {
        "childNodes": [ ],
	"id": "$obo_id",
	"lable": "$obo_hash{$obo_id}{name}",
	"parentNodes": [$parent_json],
        "description": $obo_hash{$obo_id}{def}
	},
HASH_JSON1
        print $json_hash;
    }else{
        $child = $obo_hash{$obo_id}{child};
       	my @child = split /\s/,$child;
	my $parent = $obo_hash{$obo_id}{parent};
	my $child_json = "\"".join ("\",\"",@child)."\"";
	my @parent = split /\s/,$parent;
	my $parent_json = "\"".join ("\",\"",@parent)."\"";
        my $json_hash =<<HASH_JSON2;
	"$obo_id": {
        "childNodes": [$child_json],
	"id": "$obo_id",
	"lable": \"$obo_hash{$obo_id}{name}\",
	"parentNodes": [$parent_json],
        "description": $obo_hash{$obo_id}{def},
	},
HASH_JSON2
        print $json_hash;
 #	print "$obo_id\tchild:$child\n";
 	foreach my $child_obo(@child){
 	    &get_child_obo($child_obo,\%obo_hash);
        }
    }
    return $child;
}
