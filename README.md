# Go RNA BCB-546X Fall 2019 Final project Repository
---
### Collaborators: Boris Mahule Alladassi, Yosia Mugume, Sara Hazinia, Peter Mokumo, Shravanti Suresh and Martha Ibore

Date: December 10th, 2019

### Description

This repository was created for our final project for the BCB-546X class at Iowa State University. The project was about replicating the transcriptomic analyses conducted in [Viestra *et al* (2018)](https://www.nature.com/articles/s41477-018-0299-2). It hosts the following directories and files:  

1. A **README.md** file which you are now reading. This describes the content of the repository.  
  
2. A directory **code** that has all the scripts used for this project. These are:  
			*  *Workflow.md* describes how to run the scripts stored in the directory code.  
			*  *R_script_Go_RNA.Rmd* R script used for the differential expression analysis.  
			*  *R_script_Go_RNA.html* an HTML file of the same R script.  
			*  *alignment_expression_level.sh* a bash script used processing the RNASeq file, doing the alignment and estimating gene expression level.  
			*  *prep_ref_genome.sh* a bash script to prepare the reference genome for alignment.  
			*  *venn_diagram.tiff* a Venn diagram output.  

3. A directory **data** that has the data and some intermediate files used for differential expression analysis. These are:  
			* *AgriGO_output_Dec_6th_19.txt* output obtained from the GO enrichment analysis from AgriGO   
			* *DEgenes.counts.matrix* matrix of estimated gene abundance obtained from the program RSEM for second leaf  
			* *Fourth_DEgenes.counts.matrix* matrix of estimated gene abundance obtained from the program RSEM for fourth leaf  
			* *samples.txt* the list of the NCBI SRA accession IDs to be downloaded. These accessions are RNASeq FASTQ files.

4. A **Vierstra\_et\_al\_2018.md** file that  introduces the original paper, explains the technical details of our replication of the analyses and summarizes our replication of the original results.