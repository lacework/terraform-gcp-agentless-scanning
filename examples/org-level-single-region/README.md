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

provider "google" {
  # Set the ID of the project where the scanning resources are hosted.
  project = <your-project-id>

  # Set the region where the scanning resources are hosted.
  region = <region>
}

module "lacework_gcp_agentless_scanning_org_single_region" {
  source  = "lacework/agentless-scanning/gcp"
  version = "~> 2.0"

  # Provide a list of Google Cloud projects and/or folders that you want to monitor here.
  # For projects, enter the project ID. 
  # If the project_filter_list is omitted, all projects and folders in the organization are scanned.
  #project_filter_list = [
  #  "monitored-project-1",
  #  "monitored-project-2",
  #  "folder/monitored-folder-1",
  #  "folder/monitored-folder-2
  #]

  integration_type = "ORGANIZATION"
  organization_id  = <your-org-id>

  global                    = true
  regional                  = true
  lacework_integration_name = "agentless_from_terraform"
}
```
