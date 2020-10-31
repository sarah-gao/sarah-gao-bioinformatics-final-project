#!/usr/bin/env bash

set -euo pipefail

bcftools mpileup -O b -o output_raw.bcf -f refgenome.fasta output.sorted.bam
