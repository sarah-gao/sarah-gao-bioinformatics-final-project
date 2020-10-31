#!/usr/bin/env bash

set -euo pipefail

OUTPUT_DIR="/data/sars_vcf_analysis/09_bcf_variants/"
REF_GENOME="/data/sars_vcf_analysis/02_genome_reference/sars_refgenome.fasta"

if [ $# -eq 0 ]
then
    echo "This script will call variants on the sorted bam files it is given."
    echo "Please supply a set of sorted bam files as arguments."
    exit 1
fi

# run trimmomatic to throw out bad sequences, trim when quality gets low
for sorted_bam_file in "$@"
do
    bcftools mpileup -O b -o "${OUTPUT_DIR}$(basename "$sorted_bam_file").raw.bcf" -f "$REF_GENOME" "$sorted_bam_file"
done

