#!/usr/bin/env bash

set -euo pipefail

OUTPUT_DIR="/data/sars_vcf_analysis/05_mapped_sam/"
REF_GENOME="/data/sars_vcf_analysis/02_genome_reference/sars_refgenome.fasta"

if [ $# -eq 0 ]
then
    echo "This script will run bwa on the files it is given."
    echo "Please supply a set of fastq files as arguments."
    exit 1
fi

for seq_file in "$@"
do
    bwa mem "$REF_GENOME" "$seq_file" > "${OUTPUT_DIR}$(basename $seq_file).bwa-output.sam"
done

