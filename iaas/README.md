## Terraform

Don't run `terraform` commands from within this directory. Run all commands
from the root of this repository.

### Setup To Run `terraform` Commands

You need a GCP service account key. Create and download one in JSON format
here: https://console.cloud.google.com/apis/credentials/serviceaccountkey

Download and rename the GCP service account key to `terraform.key.json`. Place
the file in the `iaas/` directory.

```console
$ mv ~/Downloads/<name-of-downloaded-gcp-service-key> ./iaas/terraform.key.json
```

From the root of this repository you should be able to initialize terraform:

```console
$ terraform init iaas
```

and check the plan

```console
$ terraform plan iaas
```
