#!/usr/bin/env bash

set -euo pipefail

# Naupaka Zimmerman
# nzimmerman@usfca.edu
# November 1, 2020

# this script downloads the reference genome fasta file for SARS-CoV-2
GENOME_BASE_URL="https://www.ncbi.nlm.nih.gov/sviewer/viewer.fcgi"
GENOME_URL_PART2="?id=NC_045512.2&db=nuccore&report=fasta&retmode=text&"
GENOME_URL_PART3="withmarkup=on&tool=portal&log$=seqview&maxdownloadsize=100000000"

# stores to project folder on RAID
GENOME_OUTPUT_FILE="/data/sars_vcf_analysis/02_genome_reference/sars_refgenome.fasta"

# download genome using curl
echo "Downloading SARS-CoV-2 reference genome..."
curl "${GENOME_BASE_URL}${GENOME_URL_PART2}${GENOME_URL_PART3}" > "$GENOME_OUTPUT_FILE"
