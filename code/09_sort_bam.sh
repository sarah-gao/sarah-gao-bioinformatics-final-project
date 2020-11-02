#!/usr/bin/env bash

set -euo pipefail

# Naupaka Zimmerman
# nzimmerman@usfca.edu
# November 1, 2020

# saved to RAID
OUTPUT_DIR="/data/sars_vcf_analysis/07_mapped_sorted_bam/"

if [ $# -eq 0 ]
then
    echo "This script will sort the bam files it is given."
    echo "Please supply a set of bam files as arguments."
    exit 1
fi

# sort each of the bam files given as input by coordinates and save the output
for bam_file in "$@"
do
    echo "Sorting ${bam_file}..."
    samtools sort -o "${OUTPUT_DIR}$(basename -s .bam $bam_file).sorted.bam" "$bam_file"
done

