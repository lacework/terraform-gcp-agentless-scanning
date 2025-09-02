# Google Cloud Project-Level for Multiple Regions

In this example we add Terraform modules to two Google Cloud regions.

- Global resources are deployed to `us-east1`
  - Service Accounts/Permissions
  - Object Storage Bucket
  - Secret Manager Secret
- Regional resources are deployed to `us-east1` and `us-central1`
  - Cloud Run Job
  - Cloud Scheduler Job

## Sample Code

Define your `versions.tf` as follows:
```hcl
terraform {
  required_version = ">= 1.5"

  required_providers {
    lacework = {
      source  = "lacework/lacework"
    }
  }
}
```

Define your `main.tf` as follows:
```hcl
# Set your Lacework profile here. With the Lacework CLI, use 
# `lacework configure list` to get a list of available profiles.
provider "lacework" {
  profile = "lw_agentless"
}

/*
This provider will be used to deploy AWLS's global scanning resources. As such, it must be assigned as
the provider in the per-region AWLS module block where `global == true`. 
For reference, see module "lacework_gcp_agentless_scanning_project_multi_region_<alias1>", which
has `global = true` and therefore is where we set this provider as the google provider.
*/
provider "google" {
  alias  = <alias1>
  region = <region1>
  # Set the project in which the scanning resources will be hosted.
  project = <your-project-id>
}

provider "google" {
  alias  = <alias2>
  region = <region2>

  # Set your default project ID for this region. This isn't required for
  # the Agentless integration, but is required by the Google Provider.
  # https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/getting_started#configuring-the-provider
  project = "default-project-id"
}

module "lacework_gcp_agentless_scanning_project_multi_region_<alias1>" {
  source  = "lacework/agentless-scanning/gcp"
  version = "~> 2.0"

  providers = {
    google = google.<alias1>
  }

  # Provide the list of Google Cloud projects that you want to monitor here.
  # Enter the ID of the projects.
  project_filter_list = [
    "monitored-project-1",
    "monitored-project-2"
  ]

  global                    = true
  regional                  = true
  lacework_integration_name = "agentless_from_terraform"
}

module "lacework_gcp_agentless_scanning_project_multi_region_<alias2>" {
  source  = "lacework/agentless-scanning/gcp"
  version = "~> 2.0"

  providers = {
    google = google.usc1
  }

  regional                = true
  global_module_reference = module.lacework_gcp_agentless_scanning_project_multi_region_<alias1>
}
```
