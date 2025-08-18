This repo contains scripts, terraform files, and BOSH manifests/ops-files that we use for operating our
infrastructure, BOSH director, and various deployments on GCP. The ops-files in this repo are used in our
automated deployments running on prod Concourse.

If you ever need to modify the prod BOSH director or any infrastructure that one of
the bosh deployments use then this is the repo you want to modify.

# Connecting to the existing bosh env

```sh
rm -rf bosh-topgun-bbl-state
gsutil cp -r gs://bosh-topgun-bbl-state/ .
export BBL_STATE_DIR=$PWD/bosh-topgun-bbl-state
```

You need a GCP service account key. Create and download one in JSON format
here: https://console.cloud.google.com/apis/credentials/serviceaccountkey

Save and name the account key `topgun-gcp-key.json` in the root of this repo.

Set the following env vars in your terminal:

```sh
export BBL_IAAS=gcp
export BBL_GCP_REGION=us-central1
export BBL_GCP_SERVICE_ACCOUNT_KEY=$PWD/topgun-gcp-key.json
export BBL_GCP_SERVICE_ACCOUNT_KEY_PATH=$PWD/topgun-gcp-key.json
export BBL_GCP_PROJECT_ID=cf-concourse-production
export BBL_GCP_ZONE=us-central1-f
```

Then run `eval "$(bbl print-env)"`. You can now run `bosh` commands.
