#!/usr/bin/env bash

set -euo pipefail

# script takes a single argument, which should be an SRA run table file

if [ $# -ne 1 ]
then
    echo "Please supply a single argument, which should be the path to an SRA runtable file"
    echo "This script expect there to be a column header row and the run IDs to be in the first column"
fi

# download fastq files for all SRA runs in runtable file, assuming first column
# and skipping first row as header
for run_id in $(tail -n +2 "$1" | cut -d, -f1)
do
    echo fasterq-dump --split-files -L 6 --outdir /data/sars_vcf_analysis/01_raw_fastq "$run_id"
done

