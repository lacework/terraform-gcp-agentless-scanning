# Google Cloud Project-Level for Multiple Regions w/ Custom Network/Subnetwork

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

locals {
  project_filter_list = [
    "monitored-project-1",
    "monitored-project-2"
  ]
}

resource "google_compute_network" "awls" {
  provider = google.use1

  name                    = "lacework-awls"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "awls_subnet_1" {
  provider = google.use1

  name          = "lacework-awls-subnet1"
  ip_cidr_range = "10.10.1.0/24"

  network = google_compute_network.awls.id
}

resource "google_compute_subnetwork" "awls_subnet_2" {
  provider = google.usc1

  name          = "lacework-awls-subnet2"
  ip_cidr_range = "10.10.2.0/24"

  network = google_compute_network.awls.id
}

resource "google_compute_firewall" "rules" {
  provider = google.use1

  name        = "awls-allow-https-egress"
  network     = google_compute_network.awls.name
  description = "Firewall policy for Lacework Agentless Workload Scanning"
  direction   = "EGRESS"

  destination_ranges = [
    "0.0.0.0/0"
  ]

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
}

module "lacework_gcp_agentless_scanning_project_multi_region_<alias1>" {
  source  = "lacework/agentless-scanning/gcp"
  version = "~> 2.0"

  providers = {
    google = google.<alias1>
  }

  project_filter_list = local.project_filter_list

  organization_id  = <your-org-id>
  global                    = true
  regional                  = true

  custom_vpc_subnet = google_compute_subnetwork.awls_subnet_1.id
}

module "lacework_gcp_agentless_scanning_project_multi_region_<alias2>" {
  source  = "lacework/agentless-scanning/gcp"
  version = "~> 2.0"

  providers = {
    google = google.<alias2>
  }

  project_filter_list = local.project_filter_list

  organization_id  = <your-org-id>
  regional                = true
  global_module_reference = module.lacework_gcp_agentless_scanning_project_multi_region_use1

  custom_vpc_subnet = google_compute_subnetwork.awls_subnet_2.id
}
```
