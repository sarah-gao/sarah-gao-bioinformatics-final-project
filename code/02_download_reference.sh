#!/usr/bin/env bash

set -euo pipefail

# this script downloads the reference genome fasta file for SARS-CoV-2

BASE_URL="https://www.ncbi.nlm.nih.gov/sviewer/viewer.fcgi"
URL_PART2="?id=NC_045512.2&db=nuccore&report=fasta&retmode=text&"
URL_PART3="withmarkup=on&tool=portal&log$=seqview&maxdownloadsize=100000000"

OUTPUT_FILE="/data/sars_vcf_analysis/02_genome_reference/sars_refgenome.fasta"

curl "${BASE_URL}${URL_PART2}${URL_PART3}" > "$OUTPUT_FILE"
