#!/usr/bin/env bash

set -euo pipefail

# Naupaka Zimmerman
# nzimmerman@usfca.edu
# November 1, 2020

# output to RAID folder
OUTPUT_DIR="/data/sars_vcf_analysis/04_trimmed_fastq/"

if [ $# -eq 0 ]
then
    echo "This script will run trimmomatic on the files it is given."
    echo "Please supply a set of fastq files as arguments."
    exit 1
fi

# run trimmomatic to throw out bad sequences, trim when quality gets low
# would be nice to split this across lines, but Trimmomatic complains about that
# Same for trying to use variables to clean this up...
for seq_file in "$@"
do
    # Note that the minimum length cutoff on this line may need to be adjusted depending
    # on the input data. If there are too many short reads, this will throuw many of them out
    # I'd bet that with RNA and degredation in these RT-PCR datasets for SARS-CoV-2, this could
    # be a major factor in some studies
    # NOTE: here this is using TrimmomaticSE for single ends
    # This is only for expediency's sake for the class, but in a real analysis this should likely
    # be adjusted to use a paired end approach if the data warrant it
    TrimmomaticSE -threads 4 -phred33 "$seq_file" "${OUTPUT_DIR}$(basename -s .fastq "$seq_file").trim.fastq" LEADING:5 TRAILING:5 SLIDINGWINDOW:8:25 MINLEN:100 
done
