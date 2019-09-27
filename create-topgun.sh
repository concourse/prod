#!/usr/bin/env bash

set -e

cd $(dirname $0)/bosh-topgun-bbl-state
rm -rf topgun-bbl-vars vars
gsutil cp -r gs://topgun-bbl-vars .
mv topgun-bbl-vars vars
lpass show --notes 'Shared-Concourse/Topgun bbl-state.json' > bbl-state.json
lpass show --notes 'Shared-Concourse/Topgun GCP Key' > topgun-gcp-key.json
bbl print-env
