#!/bin/sh
bosh create-env \
  ${BBL_STATE_DIR}/bosh-deployment/bosh.yml \
  --state  ${BBL_STATE_DIR}/vars/bosh-state.json \
  --vars-store  ${BBL_STATE_DIR}/vars/director-vars-store.yml \
  --vars-file  ${BBL_STATE_DIR}/vars/director-vars-file.yml \
  -o  ${BBL_STATE_DIR}/../bosh/ops/director-vm-size.yml \
  -o  ${BBL_STATE_DIR}/../bosh/ops/workers.yml \
  -o  ${BBL_STATE_DIR}/bosh-deployment/gcp/cpi.yml \
  -o  ${BBL_STATE_DIR}/bosh-deployment/gcp/gcs-blobstore.yml \
  -o  ${BBL_STATE_DIR}/bosh-deployment/jumpbox-user.yml \
  -o  ${BBL_STATE_DIR}/bosh-deployment/uaa.yml \
  -o  ${BBL_STATE_DIR}/bosh-deployment/credhub.yml \
  -o  ${BBL_STATE_DIR}/bbl-ops-files/gcp/bosh-director-ephemeral-ip-ops.yml \
  --var-file  gcp_credentials_json="${BBL_GCP_SERVICE_ACCOUNT_KEY_PATH}" \
  -v  project_id="${BBL_GCP_PROJECT_ID}" \
  -v  zone="${BBL_GCP_ZONE}" \
  -v  director_workers=8 \
  -v  blobstore_workers=8 \
  --var-file  agent_gcs_credentials_json="${BBL_GCP_SERVICE_ACCOUNT_KEY_PATH}" \
  --var-file  director_gcs_credentials_json="${BBL_GCP_SERVICE_ACCOUNT_KEY_PATH}" \
  -v  bucket_name="topgun-blobstore"
