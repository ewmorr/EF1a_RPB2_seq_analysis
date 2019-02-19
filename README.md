Phylogenetic analysis of EF-1alpha and RPB2 sequences

	cd GARNAS_neonectria_EF1a_RPB2_seqs

	perl ~/repo/EF1a_RPB2_seq_analysis/cat_eurofins_and_rename.pl 2-15-19 bc-sample_021519.txt > 021519_seqs.fasta

	perl ~/repo/EF1a_RPB2_seq_analysis/clip_seqs_at_primers.pl EF-1a_refSeqs_Zhao.fasta CATCGAGAAGTTCGAGAAGG TGYTCNCGRGTYTGNCCRTCYTT > EF-1a_refSeqs_Zhao.primerClipped.fasta

	perl ~/repo/EF1a_RPB2_seq_analysis/clip_seqs_at_primers.pl RPB2_refSeqs_Zhao.fasta CCCATRGCTTGYTTRCCCAT TGCCTCTGTTGATCATG > RPB2_refSeqs_Zhao.primerClipped.fasta

	perl ~/repo/EF1a_RPB2_seq_analysis/clip_seqs_at_primers.pl 021519_EF-1a_seqs.fasta CATCGAGAAGTTCGAGAAGG TGYTCNCGRGTYTGNCCRTCYTT > 021519_EF-1a_seqs.primerClipped.fasta

	perl ~/repo/EF1a_RPB2_seq_analysis/clip_seqs_at_primers.pl 021519_RPB2_seqs.fasta CATCGAGAAGTTCGAGAAGG TGYTCNCGRGTYTGNCCRTCYTT > 021519_RPB2_seqs.primerClipped.fasta

	cat EF-1a_refSeqs_Zhao.primerClipped.fasta 021519_EF-1a_seqs.primerClipped.fasta > EF-1a_refs_w_queries.fasta
	cat RPB2_refSeqs_Zhao.primerClipped.fasta 021519_RPB2_seqs.primerClipped.fasta > RPB2_refs_w_queries.fasta
	sed -i.bak "s/ /./g" EF-1a_refs_w_queries.fasta
	sed -i.bak "s/ /./g" RPB2_refs_w_queries.fasta
	rm *.bak

	muscle -in EF-1a_refs_w_queries.fasta -out EF-1a_refs_w_queries.aln 
	muscle -in RPB2_refs_w_queries.fasta -out RPB2_refs_w_queries.aln 

Open in sequence alignment viewer (e.g., Jalview) and trim manually if necessary