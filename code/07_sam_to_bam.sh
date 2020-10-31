#!/usr/bin/env bash

set -euo pipefail

samtools view -S -b output.sam > output.bam
