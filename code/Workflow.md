# Go RNA BCB-546X Fall 2019 Final_project
### Authors: Boris Mahule Alladassi, Yosia Mugume, Sara Hazinia, Peter Mokumo, Shravanti Suresh and Martha Ibore

Date: December 10th, 2019

### Description

This pipeline was developed to replicate the transcriptomic analysis carried out in [Viestra *et al* (2018)](https://www.nature.com/articles/s41477-018-0299-2).

### Dependencies
For this script to work properly, we need to first install the following modules:   
1. [SRA Toolkit](https://www.ncbi.nlm.nih.gov/sra/docs/toolkitsoft/)  
2. [Trimmomatic](http://www.usadellab.org/cms/index.php?page=trimmomatic)  
3. [Cufflinks](http://cole-trapnell-lab.github.io/cufflinks/install/)  
4. [RSEM](https://www.nature.com/articles/s41477-018-0299-2)  
5. [Bowtie 2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)

### Workflow
##### Create directories
Here, we will create the different directories that we shall need for this project. You will need a large storage disk of about 100 GB. Navigate to a desired directory and create the following directories: 
 
```mkdir -p Go_RNA_project/{Expression_out,Input_files,slurm_jobs}```  
##### Preparing the reference genome 
First, let us change directory to *Go_RNA_project*. Next, we can run a prepared bash script that will download the maize reference genome files *ea_mays_AGPv3.31.gff3* and *Zea_mays.AGPv3.31.dna.toplevel.fa* from Ensembl plant and using the program *RSEM* will help prepare the reference genome for downstream analysis.Run the following.  

```cd Go_RNA_project```  
```sbatch prep_ref_genome.sh```  

##### FASTQ files, alignment and expression level
Here, we shall run the bash script *alignment_expression_level.sh*.  
This script will download FASTQ files of RNASeq data from NCBI SRA repository using *SRA Toolkit* and remove low quality reads and adapters using the program *Trimmomatic*. Next, programs *RSEM* and *Bowtie2* will be used to do the alignment of the reads to the reference genome already prepared in previous step.  
* **Input:** the input of this program is the SRA accession ID. For this project, all 36 accession IDs are in the text file *samples.txt* and the code below, will loop over each accession ID and run.  
* **Output:** the output of this program will be the list of genes and isoforms with their estimates of abundance.  
Please, run the following.

```for name in $(cat samples.txt); do cd ./slurm_jobs/$name; sbatch /alignment_expression_level.sh $name; cd ..; done```  

##### Creating gene reads matrix
Now that we have the estimates of genes' reads, before we go to the differential expression analysis, we shall use *RSEM* to generate matrix that combines of multiple samples. Here, we do it separately for **second and fourth*** leaf.  
First let us make a directory where these matrices will be stored.  

``` mkdir gene_matrix```  

Next we compile the the paths to each sample genes' reads count to a text file using for loop.
 
```for name in $(head -n 18 samples.txt); do echo Expression_out/$name/${name}_expression.genes.results >> second_leaf_reads.txt; done```  

```for name in $(tail -n 18 samples.txt); do echo Expression_out/$name/${name}_expression.genes.results >> fourth_leaf_reads.txt; done```  

Now, we load RSEM and use its command *rsem-generate-data-matrix* to generate the matrices all stored in the directory *genes_matrix*.  

```module load rsem ```  

```rsem-generate-data-matrix $(cat second_leaf_reads.txt) > gene_matrix/DEgenes.counts.matrix```  

```rsem-generate-data-matrix $(cat second_leaf_reads.txt) > gene_matrix/DEgenes.counts.matrix```  

#### Differential expression analysis  
The differential expression analysis was carried out using R package [EBSeq](https://bioconductor.org/packages/release/bioc/html/EBSeq.html) available at Bioconductor.  
For this analysis, we shall use our R script (Rmarkdwon format) callled *R_script_Go_RNA.md*.  
* **Input:** it uses as input the gene reads matrices generate above.  
* **Output:** an *R_script_Go_RNA.html* file with all the graphs and plots, a *venn_diagram.tiff*, two comma-delimited files containing the list of the significant down or up-regulated genes forung for second and fourth leaf. 
The sript can be run directly in RStudio.  

#### GO enrichment analysis  
From the Differential expression (DE) analysis, gene ontology enrichments of the significant DE genes were identified by the [AgriGO](http://bioinfo.cau.edu.cn/agriGO/) analysis toolkit in combination with the Z. mays AGPv3.30 database.  
#### Note  
Please note that due to memory issue, the sample **SRR6977218** could not be anayzed nor included in the pipeline.  

#### References:  
For more details, here are some references.  

* To trim off the low quality reads and adapter: http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/TrimmomaticManual_V0.32.pdf  
* To convert gff3 to gtf : http://cole-trapnell-lab.github.io/cufflinks/file_formats/#gff3  
* To prepare referencde genome: https://deweylab.github.io/RSEM/rsem-prepare-reference.html  
* To align and estimate expression: http://deweylab.biostat.wisc.edu/rsem/rsem-calculate-expression.html  
* To conduct differential expression analysis: https://www.bioconductor.org/packages/devel/bioc/vignettes/EBSeq/inst/doc/EBSeq_Vignette.pdf  
* Fo GO enrichment analysis: http://bioinfo.cau.edu.cn/agriGO/