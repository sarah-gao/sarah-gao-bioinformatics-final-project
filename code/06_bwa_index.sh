#!/usr/bin/env bash

set -euo pipefail

# Naupaka Zimmerman
# nzimmerman@usfca.edu
# November 1, 2020

# This is the location of the reference genome to be indexed
REF_DIR="/data/sars_vcf_analysis/02_genome_reference/"

# index the reference genome for bwa
bwa index "${REF_DIR}sars_refgenome.fasta" > "${REF_DIR}sars_refgenome.fasta.idx"
