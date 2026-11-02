#!/usr/bin/env bash
# JamesEdition Property API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./property.sh
set -euo pipefail

curl -sS --fail-with-body -G "https://api.piloterr.com/v2/jamesedition/property" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=https://www.jamesedition.com/real_estate/munich-germany/alpine-panorama-above-lake-starnberg-new-build-project-near-munich-17793477
