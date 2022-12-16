# Project-Level with Single Region Example

Every Terraform module must have one or more examples.

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

In this example the **global** resources and **regional** resources are added.
Global resources include the per-project resources like service accounts,
roles, and object storage. Regional resources include a Cloud Scheduler Job, and
Cloud Run Service.
This example uses a single module to add both types of resources.
