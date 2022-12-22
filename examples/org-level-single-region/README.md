# Google Cloud Organization-Level for a Single Region

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

module "lacework_gcp_agentless_scanning_org_single_region" {
  source  = "lacework/agentless-scanning/gcp"
  version = "~> 0.1"

  integration_type = "ORGANIZATION"
  organization_id  = "123456789012"

  global                    = true
  regional                  = true
  lacework_integration_name = "agentless_from_terraform"
}
```
