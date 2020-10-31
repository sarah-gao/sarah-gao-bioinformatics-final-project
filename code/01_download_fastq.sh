#!/usr/bin/env bash

set -euo pipefail

fasterq-dump -L 6 "$1"
