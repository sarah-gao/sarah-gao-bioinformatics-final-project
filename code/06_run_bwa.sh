#!/usr/bin/env bash

set -euo pipefail

bwa mem refgenome.fasta SRR12433063_1.fastq SRR12433063_2.fastq > output.sam
