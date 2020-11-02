#!/usr/bin/env bash

set -euo pipefail

# Naupaka Zimmerman
# nzimmerman@usfca.edu
# November 1, 2020

# output dirs are on RAID
OUTPUT_DIR="/data/sars_vcf_analysis/05_mapped_sam/"
REF_GENOME="/data/sars_vcf_analysis/02_genome_reference/sars_refgenome.fasta"

if [ $# -eq 0 ]
then
    echo "This script will run bwa on the files it is given."
    echo "Please supply a set of fastq files as arguments."
    exit 1
fi

# align the reads in each of the samples given as input to the reference genome
# one at a time, and store the output
for seq_file in "$@"
do
    bwa mem "$REF_GENOME" "$seq_file" > "${OUTPUT_DIR}$(basename $seq_file).bwa-output.sam"
done

