# Analysis of SARS-CoV-2 SNP variants and epidemiology of the COVID-19 virus in Beijing and China

**Sarah Gao
hellosarahgao@gmail.com
Created on November 16th, 2020**

*Pipeline created by Dr. Naupaka Zimmerman. Parts of this pipeline approach are based on the pipeline 
described in the [Data Carpentry Genomics lessons](https://datacarpentry.org/genomics-workshop/), which 
are made available under a [CC-BY 4.0 license](https://creativecommons.org/licenses/by/4.0/).*

****

The goal of this project is to analyze SARS-CoV-2 genomes sampled from Beijing Ditan Hospital for SNP variants. These 
will be compared against the reference genome from Wuhan in 2019 to see if there have been any major changes since the 
virus emerged in Wuhan at the end of 2019.

This project downloads sequence data, makes variant calls, and produces a PDF report showing analyses of the called 
variants and epidemiological trends in both Beijing and the country as a whole.

****

Change Log:

* 2020-12-01: Finished writing the Methods and Results & Discussion sections. Cleaned up the plots as well.
* 2020-11-30: Added plots for confirmed cases in Beijing, daily cases in China, and effective reproductive rate in China. Added more background information.
* 2020-11-28: Finished adding plot showing number of samples with known mutations.
* 2020-11-22: Fixed check in `parse_and_tidy` function to account for null values in case of empty vcf file. Added plots for proportional SNPs and isolation sources.
* 2020-11-20: Start creating figures for R markdown report.
* 2020-11-19: Finished processing data!
* 2020-11-18: Fixed prefetch steps and incorporated into Makefile and bash processing scripts.
* 2020-11-17: Added SRA run table with Beijing data sets. Added prefetch step throughout pipeline in `01_setup_directories.sh` and `01_download_fastq.sh` bash scripts as well as in the `Makefile` clean command. Trying to work out fasterq-dump error when downloading the entire data set.
* 2020-11-16: Updated README with project goal.
