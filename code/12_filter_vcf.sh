#!/usr/bin/env bash

set -euo pipefail

OUTPUT_DIR="data/11_vcf_output_for_R/"

if [ $# -eq 0 ]
then
    echo "This script will filter short variants on vcf files it is given."
    echo "Please supply a set of vcf files as arguments."
    exit 1
fi

for vcf_file in "$@"
do
    echo "Filtering ${vcf_file}..."
    vcfutils.pl varFilter "$vcf_file" > "${OUTPUT_DIR}$(basename -s .variants.vcf "$vcf_file").final-variants.vcf"
done

