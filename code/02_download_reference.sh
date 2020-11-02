#!/usr/bin/env bash

set -euo pipefail

# this script downloads the reference genome fasta file and annotation gff for SARS-CoV-2

GENOME_BASE_URL="https://www.ncbi.nlm.nih.gov/sviewer/viewer.fcgi"
GENOME_URL_PART2="?id=NC_045512.2&db=nuccore&report=fasta&retmode=text&"
GENOME_URL_PART3="withmarkup=on&tool=portal&log$=seqview&maxdownloadsize=100000000"

ANNOTATION_BASE_URL="https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/009/858/895/"
ANNOTATION_URL_PART2="GCF_009858895.2_ASM985889v3/GCF_009858895.2_ASM985889v3_genomic.gff.gz"

GENOME_OUTPUT_FILE="/data/sars_vcf_analysis/02_genome_reference/sars_refgenome.fasta"
ANNOTATION_OUTPUT_FILE="/data/sars_vcf_analysis/02_genome_reference/sars_refgenome_annotation.gff.gz"

# download genome
echo "Downloading SARS-CoV-2 reference genome..."
curl "${GENOME_BASE_URL}${GENOME_URL_PART2}${GENOME_URL_PART3}" > "$GENOME_OUTPUT_FILE"

# download genome annotation
echo "Downloading SARS-CoV-2 reference genome annotation..."
curl "${ANNOTATION_BASE_URL}${ANNOTATION_URL_PART2}" --output "${ANNOTATION_OUTPUT_FILE}"

# extract genome annotation
gunzip -v "${ANNOTATION_OUTPUT_FILE}"
