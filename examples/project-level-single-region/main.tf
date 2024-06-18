provider "lacework" {}

provider "google" {
  region = "us-central1"
}

module "lacework_gcp_agentless_scanning_project_single_region" {
  source = "../.."

  project_filter_list = [
    "monitored-project-1",
    "monitored-project-2"
  ]

  global          = true
  regional        = true
  organization_id = "1234567890"

  lacework_integration_name = "agentless_from_terraform"
}
