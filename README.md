Phylogenetic analysis of EF-1alpha and RPB2 sequences

	cd GARNAS_neonectria_EF1a_RPB2_seqs

	perl ~/repo/EF1a_RPB2_seq_analysis/cat_eurofins_and_rename.pl 2-15-19 bc-sample_021519.txt > 021519_seqs.fasta

	#perl ~/repo/EF1a_RPB2_seq_analysis/concatenate_loci.pl EF-1a_RPB2_reference_seqs.fasta EF-1a RPB2 > reference_seqs_EF-1a_RPB2_cat.fasta

	
	#sed -i.bak "s/ /./g" reference_seqs_EF-1a_RPB2_cat.fasta 
	#sed -i.bak "s/ /./g" 021519_EF-1a_RPB2_cat.fasta 
rm *.bak

	#cat reference_seqs_EF-1a_RPB2_cat.fasta 021519_EF-1a_RPB2_cat.fasta > refs_w_queries.fasta

	muscle -in refs_w_queries.fasta -out refs_w_queries.aln 
