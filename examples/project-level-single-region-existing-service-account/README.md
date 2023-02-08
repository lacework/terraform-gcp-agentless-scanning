# Google Cloud Project-Level for a Single Region w/ Existing Service Account

In this example we add Terraform modules to one Google Cloud region.

- Global resources are deployed to the default Google provider region.
  - Service Accounts/Permissions
  - Object Storage Bucket
  - Secret Manager Secret
- Regional resources are deployed to the default Google provider region.
  - Cloud Run Job
  - Cloud Scheduler Job

## Sample Code

```hcl
provider "lacework" {}

provider "google" {}

module "lacework_gcp_agentless_scanning_project_single_region" {
  source  = "lacework/agentless-scanning/gcp"
  version = "~> 0.1"

  project_filter_list = [
    "monitored-project-1",
    "monitored-project-2"
  ]

  global                    = true
  regional                  = true
  lacework_integration_name = "agentless_from_terraform"

  use_existing_service_account = true
  service_account_name         = "my-service-account"
  service_account_private_key  = "ewogICJwcm9qZWN0X2lkIjogInNlY3JldCIsCiAgInByaXZhdGVfa2V5X2lkIjogIkdvdCB5YSEiLAogICJwcml2YXRlX2tleSI6ICJZb3Ugc2hvdWxkbid0IGJlIHJlYWRpbmcgdGhpcyBpbmZvcm1hdGlvbiA6LSkiLAogICJjbGllbnRfZW1haWwiOiAibm90QHZlcnkubmljZSIsCiAgImNsaWVudF9pZCI6ICIxMjM0Igp9Cg=="
}
```
