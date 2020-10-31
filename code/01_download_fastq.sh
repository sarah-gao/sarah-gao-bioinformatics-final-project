#!/usr/bin/env bash

set -euo pipefail

OUTPUT_DIR="/data/sars_vcf_analysis/01_raw_fastq"
TEMP_DIR="/data/sars_vcf_analysis/00_fasterq_temp"

# script takes a single argument, which should be an SRA run table file
if [ $# -ne 1 ]
then
    echo "Please supply a single argument, which should be the path to an SRA runtable file"
    echo "This script expects there to be a column header row and the run IDs to be in the first column"
    exit 1
fi

# download fastq files for all SRA runs in runtable file, assuming first column
# and skipping first row as header
for run_id in $(tail -n +2 "$1" | cut -d, -f1)
do
    fasterq-dump --split-files -L 6 --temp "$TEMP_DIR" --outdir "$OUTPUT_DIR" "$run_id"
done

# Remove all reverse reads for speed purposes
echo "Removing all reverse reads to make things run faster"
rm -vf ${OUTPUT_DIR}/*_2.fastq
