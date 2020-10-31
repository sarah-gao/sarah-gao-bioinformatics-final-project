#!/usr/bin/env bash

set -euo pipefail

OUTPUT_DIR="/data/sars_vcf_analysis/"

if [ $# -eq 0 ]
then
    echo "This script will run fastqc on the files it is given."
    echo "Please supply a set of fastq files as arguments."
    exit 1
fi

# run fastqc on all fastq files given as command-line input
fastqc -o /data/sars_vcf_analysis/03_fastqc_output -f fastq "$@"
