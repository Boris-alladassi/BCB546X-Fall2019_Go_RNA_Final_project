#!/bin/bash

# This first part is about scheduling our job on hpc clusters edit accordingly.

#SBATCH --nodes=1				## specify the number of nodes needed for this job.
#SBATCH --time=06:00:00				## specify the time duration needed for this job
#SBATCH --mail-user=<email address>		## specify your actual email address for notifications
#SBATCH --mail-type=begin			## the syste  will send an email when the job begins
#SBATCH --mail-type=end				## the syste  will send an email when the job ends
#SBATCH --error=SRR_.%J.err			## name of the standard error
#SBATCH --output=SRR_.%J.out			## name of the standard output

set -e
set -u
set -o pipefail

############## Final project of BCB 546X Fall 2019 ###########

# General info: this code was written to download the FASTQ file from NCBI SRA repository, trim it and
# align it to a prepared reference genome (see prep_ref_genome.sh) for estimating gene expression level.

# 1. Downlaod the fastq file using sratoolkit
# Kindly navigate to large storage working directory and create the following directories 
# as specified in the README file: a. Input_files b. slurm_jobs c. Expression_out

cd ./Input_files/

module load sra-toolkit

fastq-dump --origfmt $1

# 2. Trim off the low quality reads and adapters using trimmomatic

module load trimmomatic
 
wget -nc https://raw.githubusercontent.com/timflutre/trimmomatic/master/adapters/TruSeq2-SE.fa    ## Downloading adapter file.
 
trimmomatic SE -phred33 ${1}.fastq ${1}_trimmed.fastq ILLUMINACLIP:TruSeq2-SE.fa:2:30:10 LEADING:10 TRAILING:10 MAXINFO:36:0.5 MINLEN:36

# 3. Do alignment and estimate the genes' expression level

mkdir ./Expression_out/$1/

module load rsem
module load bowtie2

rsem-calculate-expression --bowtie2 --no-bam-output --bowtie2-sensitivity-level "very_sensitive" ./Input_files/${1}_trimmed.fastq ./reference_from_rsem/Zea_mays.AGPv3.31 ./Expression_out/$1/${1}_expression

rm ./Input_files/${1}.fastq

module purge 			## Here we unload all the three modules used.

# Reference: For more details, follow the links below.
# http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/TrimmomaticManual_V0.32.pdf
# http://deweylab.biostat.wisc.edu/rsem/rsem-calculate-expression.html