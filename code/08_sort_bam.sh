#!/usr/bin/env bash

set -euo pipefail

OUTPUT_DIR="/data/sars_vcf_analysis/07_mapped_sorted_bam/"

if [ $# -eq 0 ]
then
    echo "This script will sort the bam files it is given."
    echo "Please supply a set of bam files as arguments."
    exit 1
fi

# run trimmomatic to throw out bad sequences, trim when quality gets low
for bam_file in "$@"
do
    echo "Sorting ${bam_file}..."
    samtools sort -o "${OUTPUT_DIR}$(basename -s .bam $bam_file).sorted.bam" "$bam_file"
done

