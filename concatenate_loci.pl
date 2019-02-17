#!/usr/bin/perl
#Eric Morrison
#021719
#perl concatenate_loci.pl fasta locus1 locus2
#Matches sequences from two loci by finding the provided locus names, stripping them, and matching the remaining seq ID (upstream of locus name). The sequences are then concatenated with a '-' gap (in order locus1-locus2).

use strict; use warnings;

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

sub concatenate_loci{
	my($fasRef, $locus1, $locus2) = @_;
	my %fas = %$fasRef;
	my %loci;
	my $locus1regex = qr/$locus1/;
	my $locus2regex = qr/$locus2/;

	foreach my $id (sort{$a cmp $b} keys %fas){
		$id =~ /(.+) ($locus1regex|$locus2regex)/;
		my $sp = $1;
		my $locus = $2;
		$loci{$sp}{$locus} = $fas{$id};
	}
	foreach my $sp (keys %loci){
		print ">$sp $locus1-$locus2\n", $loci{$sp}{$locus1}, "----------", $loci{$sp}{$locus2}, "\n";
	}
}

#MAIN
{
	my $fasta = $ARGV[0];
	my $locus1 = $ARGV[1];
	my $locus2 = $ARGV[2];
	my $fasRef = process_fasta($fasta);
	concatenate_loci($fasRef, $locus1, $locus2);
}
