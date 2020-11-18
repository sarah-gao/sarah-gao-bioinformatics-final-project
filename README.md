# Analysis of SARS-CoV-2 SNP variants across geographies

**Sarah Gao
hellosarahgao@gmail.com
Created on November 16th, 2020**

*Pipeline created by Dr. Naupaka Zimmerman. Parts of this pipeline approach are based on the pipeline 
described in the [Data Carpentry Genomics lessons](https://datacarpentry.org/genomics-workshop/), which 
are made available under a [CC-BY 4.0 license](https://creativecommons.org/licenses/by/4.0/).*

***

The goal of this project is to analyze SARS-CoV-2 genomes sampled from Beijing Ditan Hospital in the fall of 2020 for SNP variants. These will be 
compared against the reference genome from Wuhan in 2019 to see if there have been any major changes since the virus emerged even within the same 
country.

***

Change Log:

* 2020-11-17: Added SRA run table with Beijing data sets. Added prefetch step throughout pipeline in `01_setup_directories.sh` and `01_download_fastq.sh` bash scripts as well as in the `Makefile` clean command. Trying to work out fasterq-dump error when downloading the entire data set.
* 2020-11-16: Updated README with project goal.
