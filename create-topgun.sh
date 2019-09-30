#!/usr/bin/env bash

set -e

mkdir -p $(dirname $0)/bosh-topgun-bbl-state
cd $(dirname $0)/bosh-topgun-bbl-state
rm -rf topgun-bbl-vars vars
gsutil cp -r gs://topgun-bbl-vars .
mv topgun-bbl-vars vars
lpass show --notes 'Shared-Concourse/Topgun bbl-state.json' > bbl-state.json
lpass show --notes 'Shared-Concourse/Topgun GCP Key' > topgun-gcp-key.json
export BBL_STATE_DIR=$PWD
export BBL_GCP_SERVICE_ACCOUNT_KEY=$PWD/topgun-gcp-key.json
export BBL_GCP_SERVICE_ACCOUNT_KEY_PATH=$PWD/topgun-gcp-key.json
export BBL_GCP_PROJECT_ID=cf-concourse-production
export BBL_GCP_ZONE=us-central1-a
bbl plan
cp ../create-director.sh .
cp ../topgun.yml cloud-config/
cp ../topgun.tf terraform/
