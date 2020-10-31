#!/usr/bin/env bash

set -euo pipefail

samtools sort -o output.sorted.bam output.bam
