#!/usr/bin/env bash

set -euo pipefail

bcftools call --ploidy 1 -m -v -o output_variants.vcf output_raw.bcf
