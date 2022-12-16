# Organization-Level with Multiple Regions Example

Every Terraform module must have one or more examples.

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

module "lacework_gcp_agentless_scanning_org_multi_region" {
  source  = "lacework/agentless-scanning/gcp"
  version = "~> 0.1"

  providers = {
    google = google.use1
  }

  integration_type = "ORGANIZATION"
  organization_id  = "123456789012"

  global                    = true
  regional                  = true
  lacework_integration_name = "agentless_from_terraform"
}

module "lacework_gcp_agentless_scanning_org_multi_region_usc1" {
  source  = "lacework/agentless-scanning/gcp"
  version = "~> 0.1"

  providers = {
    google = google.usc1
  }

  regional                                    = true
  agentless_orchestrate_service_account_email = module.lacework_gcp_agentless_scanning_org_multi_region.agentless_orchestrate_service_account_email
  agentless_scan_secret_id                    = module.lacework_gcp_agentless_scanning_org_multi_region.agentless_scan_secret_id
}
```

In this example the **global** resources and **regional** resources are added.
Global resources include the per-project resources like service accounts,
roles, and object storage. Regional resources include a Cloud Scheduler Job, and
Cloud Run Service.
This example uses a single module to add both types of resources.
