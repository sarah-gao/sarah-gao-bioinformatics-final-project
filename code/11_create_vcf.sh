#!/usr/bin/env bash

set -euo pipefail

OUTPUT_DIR="/data/sars_vcf_analysis/10_vcf_called/"

if [ $# -eq 0 ]
then
    echo "This script will call variants on the bcf files it is given."
    echo "Please supply a set of bcf files as arguments."
    exit 1
fi

for bcf_file in "$@"
do
    # use -m for multiallelic caller (viral population) and -v to output only variants 
    echo "Calling varants for ${bcf_file}..."
    bcftools call --ploidy 1 -m -v -o "${OUTPUT_DIR}$(basename "$bcf_file").variants.vcf" "$bcf_file"
done

