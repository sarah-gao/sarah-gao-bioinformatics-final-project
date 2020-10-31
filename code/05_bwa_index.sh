#!/usr/bin/env bash

set -euo pipefail

REF_DIR="/data/sars_vcf_analysis/02_genome_reference/"

# index the reference genome for bwa
bwa index "${REF_DIR}sars_refgenome.fasta" > "${REF_DIR}sars_refgenome.fasta.idx"
