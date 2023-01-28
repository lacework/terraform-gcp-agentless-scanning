provider "lacework" {}

provider "google" {
  alias  = "use1"
  region = "us-east1"
}

provider "google" {
  alias  = "usc1"
  region = "us-central1"
}

module "lacework_gcp_agentless_scanning_project_multi_region_use1" {
  source = "../.."

  providers = {
    google = google.use1
  }

  project_filter_list = [
    "monitored-project-1",
    "monitored-project-2"
  ]

  global                    = true
  regional                  = true
  lacework_integration_name = "agentless_from_terraform"
}

module "lacework_gcp_agentless_scanning_project_multi_region_usc1" {
  source = "../.."

  providers = {
    google = google.usc1
  }

  regional                = true
  global_module_reference = module.lacework_gcp_agentless_scanning_project_multi_region_use1
}
