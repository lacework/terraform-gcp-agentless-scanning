provider "lacework" {}

provider "google" {}

module "lacework_gcp_agentless_scanning_project_single_region" {
  source = "../.."

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
