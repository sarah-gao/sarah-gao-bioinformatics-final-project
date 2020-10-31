#!/usr/bin/env bash
set -euo pipefail

mkdir -p /data/sars_vcf_analysis/01_raw_fastq
mkdir -p /data/sars_vcf_analysis/02_genome_reference
mkdir -p /data/sars_vcf_analysis/03_fastqc_output
mkdir -p /data/sars_vcf_analysis/04_trimmed_fastq
mkdir -p /data/sars_vcf_analysis/05_mapped_sam
mkdir -p /data/sars_vcf_analysis/06_mapped_bam
mkdir -p /data/sars_vcf_analysis/07_mapped_sorted_bam
mkdir -p /data/sars_vcf_analysis/08_bcf_variants
mkdir -p /data/sars_vcf_analysis/09_vcf_called

# note this is in repo not in root /data
mkdir -p data/00_sra_runtable
mkdir -p data/10_vcf_output_for_R
