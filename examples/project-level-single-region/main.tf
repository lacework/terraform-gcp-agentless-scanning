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

  global                    = true
  regional                  = true
  lacework_integration_name = "agentless_from_terraform"
}
