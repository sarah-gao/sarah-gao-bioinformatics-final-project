#!/usr/bin/env bash

set -euo pipefail

# Naupaka Zimmerman
# nzimmerman@usfca.edu
# November 1, 2020

# save to RAID
OUTPUT_DIR="/data/sars_vcf_analysis/08_flagstats/"

if [ $# -eq 0 ]
then
    echo "This script will run flagstats on the sorted bam files it is given."
    echo "Please supply a set of sorted bam files as arguments."
    exit 1
fi

# run flagstats to get some info on the sorted bam files
for sorted_bam_file in "$@"
do
    echo "Running flagstats on ${sorted_bam_file}..."
    samtools flagstat "$sorted_bam_file" > "${OUTPUT_DIR}$(basename $sorted_bam_file).stats.txt"
done

