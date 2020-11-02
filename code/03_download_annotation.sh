#!/usr/bin/env bash

set -euo pipefail

# Naupaka Zimmerman
# nzimmerman@usfca.edu
# November 1, 2020

# this script downloads the annotation gff for SARS-CoV-2
ANNOTATION_BASE_URL="https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/009/858/895/"
ANNOTATION_URL_PART2="GCF_009858895.2_ASM985889v3/GCF_009858895.2_ASM985889v3_genomic.gff.gz"

ANNOTATION_OUTPUT_FILE="/data/sars_vcf_analysis/02_genome_reference/sars_refgenome_annotation.gff.gz"

# download genome annotation
echo "Downloading SARS-CoV-2 reference genome annotation..."
curl "${ANNOTATION_BASE_URL}${ANNOTATION_URL_PART2}" --output "${ANNOTATION_OUTPUT_FILE}"

# extract genome annotation
gunzip -v "${ANNOTATION_OUTPUT_FILE}"
