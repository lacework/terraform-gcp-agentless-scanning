provider "lacework" {}

provider "google" {}

module "lacework_gcp_agentless_scanning_org_single_region" {
  source = "../.."

  integration_type = "ORGANIZATION"
  organization_id  = "123456789012"

  global                    = true
  regional                  = true
  lacework_integration_name = "agentless_from_terraform"
}
