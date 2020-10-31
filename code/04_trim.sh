#!/usr/bin/env bash

set -euo pipefail

OUTPUT_DIR="/data/sars_vcf_analysis/04_trimmed_fastq/"
TRIM_PARAMS="LEADING:5 TRAILING:5 SLIDINGWINDOW:8:25 MINLEN:200"

if [ $# -eq 0 ]
then
    echo "This script will run trimmomatic on the files it is given."
    echo "Please supply a set of fastq files as arguments."
    exit 1
fi

# run trimmomatic to throw out bad sequences, trim when quality gets low
for seq_file in "$@"
do
    echo TrimmomaticSE -threads 4 -phred33 "$seq_file" "${OUTPUT_DIR}$(basename -s .fastq "$seq_file").trim.fastq" "$TRIM_PARAMS" 
done
