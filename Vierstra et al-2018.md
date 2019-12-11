
# Vierstra et al-2018


## Project summary


The  turnover  of  cytoplasmic  material  by  autophagic  encapsulation  and  delivery to  vacuoles  is  essential  for  recycling  cellu-lar constituents, especially under nutrient-limiting conditions. In this paper, the authors aim to determine how cells/tissues rely on autophagy by applying in-depth multi-omic analyses to study maize (Zea mays) autophagy mutants grown under nitrogen-replete and starvation conditions. They report broad alterations in the leaf metabolome  in plants that were missing the core autophagy component ATG12, even in the absence of stress, particularly affecting products of lipid turnover and secondary metabolites, which were underpinned by substantial changes in the transcriptome and/or proteome. They also performed cross-comparison of messenger RNA and protein abundances which allowed for the identification of organelles, protein complexes and individual proteins targeted for selective autophagic clear-ance,  and  revealed  that several processes  were controlled  by  this  catabolism.  Collectively, they  describe  a facile  multi-omic  strategy  to  survey  autophagic  substrates,  and  show  that  autophagy  has  a  remarkable  influence  in                   eukaryotic  proteomes  and membranes both before and during nutrient stress.

You can access the paper at: [https://www.nature.com/articles/s41477-018-0299-2]()


## Overall theme of project

Given the length and the extent of experiments and data analysis that was described in this paper, we chose to replicate one of the crucial figures(data) that eventually contributes to to their conclusions. As our final project, we seek to replicate the figures they obtained in Figure 4 of the main paper by mimicking their techniques to perform data analysis. For this purpose, we use Unix commands to extract and clean up the data, bash scripts to prepare and align the reference genome, followed by R scripts to transform the data into results that can be interpreted for scientific enhancement. 


## Data selection

We used data that showed that the protease and lipid metabolic transcripts are up-regulate din autophagy mutants. We tried to replicate the steps as excatly followed by the authors in the paper. Around 25000 maize transcripts from the first and the fourth leaf were obtained from Illumina based RNA sequencing in the original paper. This included three data-sets, wild-type, atg12-1 and atg12-2 leaves grown with or without nitrogen using the three mean biological replicates studied above by metabolomics. 


## Data acquisition

SRA toolkit
[https://www.ncbi.nlm.nih.gov/sra/docs/toolkitsoft/
]()

Trimming the files 
[http://www.usadellab.org/cms/index.php?page=trimmomatic
]()

FASTQ files were processed with Trimmomatic v0.3671 to remove adapters and low-quality reads using the following ordered steps: ILLUMINACLIP (fasta = TruSeq2-SE.fa; SeedMismatches = 2; PalindroneClipThreshold = 30; SimpleClipThreshold = 10); LEADING = 10; TRAILING = 10; MAXINFO (TargetLength = 36; Strictness = 0.5); MINLEN = 36.
We were however unable to download SRR_26977213 atg 12-1 R2-N file. 

## Bowtie mapping and cufflinks to prepare the reference genome and alignment 


Cufflinks
[http://cole-trapnell-lab.github.io/cufflinks/install/
]()

Bowtie
[http://bowtie-bio.sourceforge.net/bowtie2/index.shtml]()

The B73 reference files ‘Zea_mays_AGPv3.31.gff3’ and ‘Zea_mays.AGPv3.31.dna.toplevel.fa’ were downloaded from ENSEMBL Plants (http://plants.ensembl.org) and the former converted to GTF2 format in Cufflinks v2.2.172. RSEM v1.2.2173 was then used to prepare the reference B73 genome and, coupled with Bowtie274, to align and estimate expression levels under the default settings except that Bowtie2- sensitivity-level was set at ‘very_sensitive’.

## Differential gene analysis

Differntial gene analysis was used to study the expression level and compare the levels of regulation between the wild type and the mutants.
The differential expression analysis was carried out using R package EBSeq available at Bioconductor. These results were further visualised in the from of scatter plots, Venn diagrams and heat maps.


## Venn diagrams

Cross-comparisons identified 3,082 and 2,426 transcripts that were significantly up- or down-regulated, respectively, in both atg12 backgrounds versus wild type (false discovery rate (FDR) < 0.05). we replicated this in our analysis. we used R to visualise this. 

## Heat maps 

The significantly up- or down-regulated transcripts (atg12 versus wild type) were illustrated by heat maps in the original paper and replicated by us. A seperate code was used to generate the heat maps. These were generated using R.

## Gene ontology/Enrichment analysis 
Agri-Go was used for this purpose. The subsequent plots obtained from the agri-Go data were visualised using R scripts. In the original paper, the authors also employed similar enrichment softwares, though it was not explicitly mentioned. We performed this analysis for the intersectional data from the second leaf(in the presence and absence of nitrogen), from the fourth leaf( in the presence and absence of nitrogen), and the intersection of the second and the fourth leaf in the presence and absence of nitrogen. 

## Results
Our results, in terms of the heat maps and the Venn diagram and the PCA scatter plots matched the results from the original paper. There were some discrepencies in the exact number of genes that we identified versus the paper but that can be attributed to two major reasons. We were unable to download one data set despite many efforts and this exempted us from having all the information. Also, some of the softwares utilised by the authors have many versions, each version containing different attributes. Since we weren't sure of which version to use, we used the latest versions for most of them. 

## Data access

For those who seek to know more about our project and the methodology, we have a GitHUb repository with the codes, workflow and the data files. The link to the repository is as follows: [https://github.com/Boris-alladassi/BCB546X-Fall2019_Go_RNA_Final_project.git]()

## References

For more details, here are some references.

To trim off the low quality reads and adapter: [http://www.usadellab.org/cms/uploads/supplementary/]()

Trimmomatic/TrimmomaticManual_V0.32.pdf
To convert gff3 to gtf :[ http://cole-trapnell-[lab.github.io/cufflinks/file_formats/#gff3]()
]()

To prepare reference genome: [https://[deweylab.github.io/RSEM/rsem-prepare-reference.html]()
]()

To align and estimate expression: [http://deweylab.biostat.wisc.edu/rsem/rsem-calculate-expression.html
]()

To conduct differential expression analysis: [https://www.bioconductor.org/packages/devel/bioc/vignettes/EBSeq/inst/doc/EBSeq_Vignette.pdf
]()

For GO enrichment analysis: [http://bioinfo.cau.edu.cn/agriGO/
]()