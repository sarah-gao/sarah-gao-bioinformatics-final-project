#!/usr/bin/env bash

set -euo pipefail

OUTPUT_DIR="/data/sars_vcf_analysis/06_mapped_bam/"

if [ $# -eq 0 ]
then
    echo "This script will convert the sam files it is given to bam."
    echo "Please supply a set of sam files as arguments."
    exit 1
fi

# run trimmomatic to throw out bad sequences, trim when quality gets low
for sam_file in "$@"
do
    echo "Converting $sam_file to bam..."
    samtools view -S -b --verbosity 2 "$sam_file" > "${OUTPUT_DIR}$(basename -s .sam "$sam_file").bam"
done

