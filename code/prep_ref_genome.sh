#!/bin/bash

# This first part is about scheduling our job on hpc clusters.

#SBATCH --nodes=1				## specify the number of nodes needed for this job.
#SBATCH --time=02:00:00				## specify the time duration needed for this job
#SBATCH --mail-user=<email address>		## specify your actual email address for notifications
#SBATCH --mail-type=begin			## the syste  will send an email when the job begins
#SBATCH --mail-type=end				## the syste  will send an email when the job ends
#SBATCH --error=genome_prep_.%J.err		## name of the standard error
#SBATCH --output=genome_prep_.%J.out		## name of the standard output

set -e
set -u
set -o pipefail

############## Final project of BCB 546X Fall 2019 ###########

# General info: this code was written to download the maize B73 reference genome version 3 files from ensembl plants
# and prepare them for alingment and gene expression level analysis using rsem
 
# 1. Download the "gff3" file from ensembl plant use command gffread from cufflinks to transform it to gtf format
 
wget ftp://ftp.ensemblgenomes.org/pub/plants/release-31/gff3/zea_mays/Zea_mays.AGPv3.31.gff3.gz
 
zcat Zea_mays.AGPv3.31.gff3.gz > Zea_mays.AGPv3.31.gff3
 
module load cufflinks

gffread Zea_mays.AGPv3.31.gff3 -T -o Zea_mays.AGPv3.31.gtf
 
head Zea_mays.AGPv3.31.gtf 			## Just to inspect the output file.

# 2. Download the reference genome fasta file and unzip it 

wget ftp://ftp.ensemblgenomes.org/pub/plants/release-31/fasta/zea_mays/dna/Zea_mays.AGPv3.31.dna.toplevel.fa.gz
 
zcat Zea_mays.AGPv3.31.dna.toplevel.fa.gz > Zea_mays.AGPv3.31.dna.toplevel.fa

head Zea_mays.AGPv3.31.dna.toplevel.fa 		## Just to inspect the output file.

# 3. Now we can prepare the reference genome using rsem and bowtie2

module load rsem

module load bowtie2

mkdir reference_from_rsem

rsem-prepare-reference --gtf Zea_mays.AGPv3.31.gtf --bowtie2 Zea_mays.AGPv3.31.dna.toplevel.fa reference_from_rsem/Zea_mays.AGPv3.31

module purge 					## Here we unload all the three modules.


# Reference: For more details, follow the links below.
# https://deweylab.github.io/RSEM/rsem-prepare-reference.html
# http://cole-trapnell-lab.github.io/cufflinks/file_formats/#gff3