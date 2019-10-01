#!/usr/bin/env bash

set -e

rm -rf bosh-topgun-bbl-state
gsutil cp -r gs://bosh-topgun-bbl-state/ .
export BBL_STATE_DIR=$PWD/bosh-topgun-bbl-state
lpass show --notes 'Shared-Concourse/Topgun GCP Key' > topgun-gcp-key.json
export BBL_IAAS=gcp
export BBL_GCP_REGION=us-central1
export BBL_GCP_SERVICE_ACCOUNT_KEY=$PWD/topgun-gcp-key.json
export BBL_GCP_SERVICE_ACCOUNT_KEY_PATH=$PWD/topgun-gcp-key.json
export BBL_GCP_PROJECT_ID=cf-concourse-production
export BBL_GCP_ZONE=us-central1-f
pushd bosh-topgun-bbl-state
  bbl plan
  cp ../create-director.sh ./
  cp ../topgun.yml ./cloud-config/
  cp ../topgun.tf ./terraform/
  bbl up
  gsutil cp -r . gs://bosh-topgun-bbl-state/
popd
