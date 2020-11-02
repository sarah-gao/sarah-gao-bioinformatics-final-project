#!/usr/bin/env bash

set -euo pipefail

# Naupaka Zimmerman
# nzimmerman@usfca.edu
# November 1, 2020

# this script will run fastqc on a list of fastq files given as input

# set output dir to be on RAID
OUTPUT_DIR="/data/sars_vcf_analysis/03_fastqc_output"

if [ $# -eq 0 ]
then
    echo "This script will run fastqc on the files it is given."
    echo "Please supply a set of fastq files as arguments."
    exit 1
fi

# run fastqc on all fastq files given as command-line input
fastqc -o "$OUTPUT_DIR" -f fastq "$@"
