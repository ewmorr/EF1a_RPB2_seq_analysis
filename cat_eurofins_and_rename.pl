#!/usr/bin/perl
#Eric Morrison
#021519
#perl cat_eurofins_and_rename.pl seq_dir metadata.txt

use strict;
use warnings;

sub process_seq_files{
	my $seqDir = $_[0];
	chomp(my @files = `ls $seqDir/*.seq`);
	my %seqs;
	foreach my $file (@files){
		open(TEMP, "$file") || die "Can't open file\n";
		chomp(my @seq = <TEMP>);
		if(scalar @seq == 1){
			@seq = convert_linefeeds($seq[0]);
		}
		$seq[0] =~ />(.+?)_PREMIX/;
		$seqs{$1} = $seq[1];
	}
	return(\%seqs);
}

sub process_meta_data{
	my $metaData = $_[0];
	open(META, "$metaData") || die "Can't open metadata\n";
	chomp(my @meta = <META>);
	if(scalar @meta == 1){
		@meta = convert_linefeeds($meta[0]);
	}
	my %meta;
	foreach my $line (@meta){
		my @line = split("\t", $line);
		$meta{$line[0]} = [@line];
	}
	return(\%meta);
}

sub replace_names_print{
	my($seqRef, $metaRef) = @_;
	my %seqs = %$seqRef;
	my %meta = %$metaRef;
	
	foreach my $id (sort {$a cmp $b} keys %seqs){
		my $name = $meta{$id}[1]." ".$meta{$id}[2];
		my $seq;
		if($meta{$id}[3] eq "rev"){
			$seq = reverse_complement($seqs{$id});
		}else{
			$seq = $seqs{$id};
		}
		print ">", $name, "\n", $seq, "\n"
	}
}

sub convert_linefeeds{
	my $line = $_[0];
	$line =~ s/\r|\r\n|\n/\n/g;
	return(split("\n", $line));
}

sub reverse_complement{
	my $seq = $_[0];
	$seq = reverse($seq);
	$seq =~ tr/GCATgcatN/CGTAcgtaN/;
	return($seq);
}

#MAIN
{
	my $seqDir = $ARGV[0];
	my $metaData = $ARGV[1];
	
	my $seqRef = process_seq_files($seqDir);
	my $metaRef = process_meta_data($metaData);
	replace_names_print($seqRef, $metaRef);
}
