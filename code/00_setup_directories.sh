#!/usr/bin/env bash
set -euo pipefail

mkdir -p /data/01_raw_fastq
mkdir -p /data/02_genome_reference
mkdir -p /data/03_fastqc_output
mkdir -p /data/04_trimmed_fastq
mkdir -p /data/05_mapped_sam
mkdir -p /data/06_mapped_bam
mkdir -p /data/07_mapped_sorted_bam
mkdir -p /data/08_bcf_variants
mkdir -p /data/09_vcf_called

# note this is in repo not in root /data
mkdir -p data/00_sra_runtable
mkdir -p data/10_vcf_output_for_R
