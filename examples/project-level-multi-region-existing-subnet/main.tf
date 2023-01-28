provider "lacework" {}

provider "google" {
  alias  = "use1"
  region = "us-east1"
}

provider "google" {
  alias  = "usc1"
  region = "us-central1"
}

resource "google_compute_network" "awls" {
  provider = google.use1

  name                    = "lacework-awls"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "awls_subnet_1" {
  provider = google.use1

  name          = "lacework-awls-subnet1"
  ip_cidr_range = "10.10.1.0/24"

  network = google_compute_network.awls.id
}

resource "google_compute_subnetwork" "awls_subnet_2" {
  provider = google.usc1

  name          = "lacework-awls-subnet2"
  ip_cidr_range = "10.10.2.0/24"

  network = google_compute_network.awls.id
}

resource "google_compute_firewall" "rules" {
  provider = google.use1

  name        = "awls-allow-https-egress"
  network     = google_compute_network.awls.name
  description = "Firewall policy for Lacework Agentless Workload Scanning"
  direction   = "EGRESS"

  destination_ranges = [
    "0.0.0.0/0"
  ]

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
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

  global   = true
  regional = true

  use_existing_subnet = true
  subnet_id           = google_compute_subnetwork.awls_subnet_1.id
}

module "lacework_gcp_agentless_scanning_project_multi_region_usc1" {
  source = "../.."

  providers = {
    google = google.usc1
  }

  regional = true

  use_existing_subnet = true
  subnet_id           = google_compute_subnetwork.awls_subnet_2.id

  global_module_reference = module.lacework_gcp_agentless_scanning_project_multi_region_use1
}
