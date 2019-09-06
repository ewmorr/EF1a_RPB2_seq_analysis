Phylogenetic analysis of EF-1alpha and RPB2 sequences

	cd GARNAS_neonectria_EF1a_RPB2_seqs

cat, reformat, and quality trim Eurofins sequence files, one per dir

	perl ~/repo/EF1a_RPB2_seq_analysis/cat_eurofins_and_rename.pl 2-15-19 bc-sample_021519.txt 0.05 > 021519_seqsa.fasta
    
    perl ~/repo/EF1a_RPB2_seq_analysis/cat_eurofins_and_rename.pl 2-27-19 bc-sample_022719.txt 0.05 > 022719_seqs.fasta

combine multiple results and filter to separate files per loci

    cat 021519_seqsa.fasta 022719_seqs.fasta | grep -A1 "RPB2" | awk '!/--/' | sed "s/ /./g" > RPB2_culture_seqs.fasta
    cat 021519_seqsa.fasta 022719_seqs.fasta | grep -A1 "EF-1a" | awk '!/--/' | sed "s/ /./g" > EF1a_culture_seqs.fasta
    

Trim reference sequences and sample sequences at Zhao primers before alignment

	perl ~/repo/EF1a_RPB2_seq_analysis/clip_seqs_at_primers.pl EF-1a_refSeqs_Zhao.fasta CATCGAGAAGTTCGAGAAGG TGYTCNCGRGTYTGNCCRTCYTT > EF-1a_refSeqs_Zhao.primerClipped.fasta

	perl ~/repo/EF1a_RPB2_seq_analysis/clip_seqs_at_primers.pl RPB2_refSeqs_Zhao.fasta CCCATRGCTTGYTTRCCCAT TGCCTCTGTTGATCATG > RPB2_refSeqs_Zhao.primerClipped.fasta
    
Aligning ref seqs before cat with queries facilitates downstream alignment

    muscle -in EF-1a_refSeqs_Zhao.primerClipped.fasta -out EF-1a_refSeqs_Zhao.primerClipped.aln
    muscle -in RPB2_refSeqs_Zhao.primerClipped.fasta -out RPB2_refSeqs_Zhao.primerClipped.aln

Open in Jalview and trim manually. RPB2 did not require trimming (just coccinea, major, faginata, ditissima). EF-1a did require trimming and saved as

    EF-1a_refSeqs_Zhao.primerClipped.alnTrimmed.fasta
    
Trim primers on queries

	perl ~/repo/EF1a_RPB2_seq_analysis/clip_seqs_at_primers.pl EF1a_culture_seqs.fasta CATCGAGAAGTTCGAGAAGG TGYTCNCGRGTYTGNCCRTCYTT > EF1a_culture_seqs.primerClipped.fasta

	perl ~/repo/EF1a_RPB2_seq_analysis/clip_seqs_at_primers.pl RPB2_culture_seqs.fasta CATCGAGAAGTTCGAGAAGG TGYTCNCGRGTYTGNCCRTCYTT > RPB2_culture_seqs.primerClipped.fasta

combine with reference alignments

	cat EF-1a_refSeqs_Zhao.primerClipped.alnTrimmed.fasta EF1a_culture_seqs.primerClipped.fasta > EF-1a_refs_w_queries.fasta
	cat RPB2_refSeqs_Zhao.primerClipped.aln RPB2_culture_seqs.primerClipped.fasta > RPB2_refs_w_queries.fasta

	muscle -in EF-1a_refs_w_queries.fasta -out EF-1a_refs_w_queries.aln 
	muscle -in RPB2_refs_w_queries.fasta -out RPB2_refs_w_queries.aln 

Open in sequence alignment viewer (e.g., Jalview) and trim manually
    * EF1a trimmed at pos 29 and 548 (original alignment)
    * RPB2 trimmed at pos 20 and 455 (original alignment)

```EF-1a_refs_w_queries.alnTrim.fasta```
```RPB2_refs_w_queries.alnTrim.fasta```



# ~
Quality trim at 10% Ns instead of 5% to check alignment accuracy at lower quality stringency

cat, reformat, and quality trim Eurofins sequence files, one per dir

    perl ~/repo/EF1a_RPB2_seq_analysis/cat_eurofins_and_rename.pl 2-15-19 bc-sample_021519.txt 0.1 > 021519_seqs_0.1.fasta

    perl ~/repo/EF1a_RPB2_seq_analysis/cat_eurofins_and_rename.pl 2-27-19 bc-sample_022719.txt 0.1 > 022719_seqs_0.1.fasta

combine multiple results and filter to separate files per loci

    cat 021519_seqs_0.1.fasta 022719_seqs_0.1.fasta | grep -A1 "RPB2" | awk '!/--/' | sed "s/ /./g" > RPB2_culture_seqs_0.1.fasta
    cat 021519_seqs_0.1.fasta 022719_seqs_0.1.fasta | grep -A1 "EF-1a" | awk '!/--/' | sed "s/ /./g" > EF1a_culture_seqs_0.1.fasta

    grep ">" RPB2_culture_seqs_0.1.fasta | wc -l
    grep ">" RPB2_culture_seqs.fasta | wc -l
    
RPB2 did not include more seqs so proceed with EF-1a only

Trim primers on queries (this doesn't work on Ns so will perform poorly)

    perl ~/repo/EF1a_RPB2_seq_analysis/clip_seqs_at_primers.pl EF1a_culture_seqs_0.1.fasta CATCGAGAAGTTCGAGAAGG TGYTCNCGRGTYTGNCCRTCYTT > EF1a_culture_seqs_0.1.primerClipped.fasta

 combine with reference alignments

    cat EF-1a_refSeqs_Zhao.primerClipped.alnTrimmed.fasta EF1a_culture_seqs_0.1.primerClipped.fasta > EF-1a_refs_w_queries_0.1.fasta
 
    muscle -in EF-1a_refs_w_queries_0.1.fasta -out EF-1a_refs_w_queries_0.1.aln

Open in sequence alignment viewer (e.g., Jalview) and trim manually
* EF1a trimmed at pos 427 and 949 (original alignment)

```EF-1a_refs_w_queries_0.1.alnTrim.fasta```


