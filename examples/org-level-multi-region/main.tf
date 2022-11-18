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
  source = "../.."

  providers = {
    google = google.use1
  }

  integration_type = "ORGANIZATION"
  organization_id  = "123456789012"

  global          = true
  regional        = true
  lacework_domain = "agentless_from_terraform"
}

module "lacework_gcp_agentless_scanning_org_multi_region_usc1" {
  source = "../.."

  providers = {
    google = google.usc1
  }

  regional                                    = true
  agentless_orchestrate_service_account_email = module.lacework_gcp_agentless_scanning_org_multi_region.agentless_orchestrate_service_account_email
}
