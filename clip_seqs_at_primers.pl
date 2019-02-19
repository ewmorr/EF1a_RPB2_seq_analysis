#!/usr/bin/perl
#Eric Morrison
#021919
#Usage perl clip_seqs_at_primers.pl seqs.fasta primer1 primer2

use strict;
use warnings;

sub process_fasta{
	my $fasta = $_[0];
	open(FAS, "$fasta") || die "can't open fasta file\n";
	chomp(my @fasta = <FAS>);
	my $fas = join("::::::::::::", @fasta);
	my @fas = split(">", $fas);
	shift @fas;
	my %fas;
	foreach my $seq (@fas){
		my @seq = split("::::::::::::", $seq);
		$fas{$seq[0]} = join("", @seq[1..$#seq]);
	}
	return(\%fas);
}

sub build_degen_primer{
	my @seq = split("", $_[0]);
	my @degen;
	for(my $i = 0; $i < @seq; $i++){
		$degen[$i] = degen_table($seq[$i]);
	}
	return(join("", @degen));
}

sub clip_and_print{
	my($fasRef, $primer1, $primer2) = @_;
	my %fas = %$fasRef;
	foreach my $id (keys %fas){
		#if($fas{$id} =~ /^.*$primer1/){print "primer1\n"}
		#if($fas{$id} =~ /$primer2.*$/){print "primer2\n"}
		$fas{$id} =~ s/^.*$primer1//;
		$fas{$id} =~ s/$primer2.*$//;
		print ">", $id, "\n", $fas{$id}, "\n";
	}
}

sub degen_table{
	my $nt = $_[0];
	my %dntToNt = (
	"A" => "A",
	"T" => "T",
	"C" => "C",
	"G" => "G",
	"R" => "[AG]",
	"Y" => "[CT]",
	"N" => "[AGCT]",
	"W" => "[AT]",
	"S" => "[GC]",
	"M" => "[AC]",
	"K" => "[GT]",
	"B" => "[GCT]",
	"H" => "[ACT]",
	"V" => "[AGC]",
	);
	my $newNT = $dntToNt{$nt};
	return($newNT);
}

sub reverse_complement{
	my $seq = $_[0];
	$seq = reverse($seq);
	$seq =~ tr/GCATgcatN[]/CGTAcgtaN][/;
	return($seq);
}

#MAIN
{
	my $fasta = $ARGV[0];
	my $primer1 = $ARGV[1];
	my $primer2 = $ARGV[2];
	
	my $fasRef = process_fasta($fasta);
	my $degenPrimer1 = build_degen_primer($primer1);
	my $degenPrimer2 = build_degen_primer($primer2);
	clip_and_print($fasRef, $degenPrimer1, reverse_complement($degenPrimer2));
}
