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

```hcl
provider "lacework" {}

provider "google" {
  alias  = "use1"
  region = "us-east1"
}

provider "google" {
  alias  = "usc1"
  region = "us-central1"
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

module "lacework_gcp_agentless_scanning_project_multi_region_use1" {
  source  = "lacework/agentless-scanning/gcp"
  version = "~> 0.1"

  providers = {
    google = google.use1
  }

  project_filter_list = local.project_filter_list

  global                    = true
  regional                  = true

  custom_vpc_subnet = google_compute_subnetwork.awls_subnet_1.id
}

module "lacework_gcp_agentless_scanning_project_multi_region_usc1" {
  source  = "lacework/agentless-scanning/gcp"
  version = "~> 0.1"

  providers = {
    google = google.usc1
  }

  project_filter_list = local.project_filter_list

  regional                = true
  global_module_reference = module.lacework_gcp_agentless_scanning_project_multi_region_use1

  custom_vpc_subnet = google_compute_subnetwork.awls_subnet_2.id
}
```
