locals {
  project_id       = length(var.project_id) > 0 ? var.project_id : data.google_project.selected.project_id
  suffix           = length(var.suffix) > 0 ? var.suffix : random_id.uniq.hex
  lacework_account = length(var.lacework_account) > 0 ? var.lacework_account : trimsuffix(data.lacework_user_profile.current.url, ".${var.lacework_domain}")

  agentless_orchestrate_service_account_email = var.global ? google_service_account.agentless_orchestrate[0].email : var.agentless_orchestrate_service_account_email
  agentless_scan_service_account_email        = var.global ? google_service_account.agentless_scan[0].email : var.agentless_scan_service_account_email

  service_account_name     = var.global ? (length(var.service_account_name) > 0 ? var.service_account_name : "${var.prefix}-sa-${local.suffix}") : ""
  service_account_json_key = var.global ? jsondecode(base64decode(module.lacework_agentless_scan_svc_account[0].private_key)) : jsondecode("{}")
  service_account_permissions = var.global ? toset([
    "roles/storage.objectViewer",
    "roles/run.invoker",
  ]) : []

  included_projects = var.global ? toset([for project in var.project_filter_list : project if !(substr(project, 0, 1) == "-")]) : []
  excluded_projects = var.global ? toset([for project in var.project_filter_list : project if substr(project, 0, 1) == "-"]) : []

  bucket_name = var.global ? google_storage_bucket.lacework_bucket[0].name : ""
  bucket_roles = var.global ? ({
    "roles/storage.admin" = [
      "projectEditor:${local.project_id}",
      "projectOwner:${local.project_id}"
    ],
    "roles/storage.objectCreator" = [
      "serviceAccount:${local.agentless_orchestrate_service_account_email}",
      "serviceAccount:${local.agentless_scan_service_account_email}"
    ],
    "roles/storage.objectViewer" = [
      "serviceAccount:${local.service_account_json_key.client_email}",
      "projectViewer:${local.project_id}"
    ]
  }) : ({})
}

resource "random_id" "uniq" {
  byte_length = 2
}

data "lacework_user_profile" "current" {}

data "google_project" "selected" {}

resource "google_project_service" "required_apis" {
  for_each = var.required_apis

  project = local.project_id
  service = each.value

  disable_on_destroy = false
}

// Global - The following are resources are created once per integration
// includes the lacework cloud account integration
// Only create global resources if global variable is set to true
// count = var.global ? 1 : 0

// Secret Manager
resource "google_secret_manager_secret" "agentless_orchestrate" {
  count = var.global ? 1 : 0

  secret_id = "${var.prefix}-secret-${local.suffix}"
  project   = local.project_id

  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }

  labels = merge(var.labels)

  depends_on = [google_project_service.required_apis]
}

resource "google_secret_manager_secret_version" "agentless_orchestrate" {
  count = var.global ? 1 : 0

  secret = google_secret_manager_secret.agentless_orchestrate[0].id
  # TODO: Add "token": "${lacework_integration_gcp_agentless_scanning.lacework_cloud_account[0].server_token}" to the secret_data
  secret_data = <<EOF
   {
    "account": "${local.lacework_account}",
    "scanner_service_account": "${local.agentless_scan_service_account_email}",
   }
EOF
}

resource "google_secret_manager_secret_iam_member" "member" {
  count = var.global ? 1 : 0

  project   = local.project_id
  secret_id = google_secret_manager_secret.agentless_orchestrate[0].secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${local.agentless_orchestrate_service_account_email}"
}

// Storage Bucket for Analysis Data
resource "google_storage_bucket" "lacework_bucket" {
  count = var.global ? 1 : 0

  project       = local.project_id
  name          = "${var.prefix}-bucket-${local.suffix}"
  force_destroy = var.bucket_force_destroy
  location      = var.region

  uniform_bucket_level_access = var.bucket_enable_ubla

  dynamic "lifecycle_rule" {
    for_each = var.bucket_lifecycle_rule_age > 0 ? [1] : []
    content {
      condition {
        age = var.bucket_lifecycle_rule_age
      }
      action {
        type = "Delete"
      }
    }
  }

  labels = merge(var.labels)

  depends_on = [google_project_service.required_apis]
}

resource "google_storage_bucket_iam_binding" "lacework_bucket" {
  for_each = local.bucket_roles

  role    = each.key
  members = each.value
  bucket  = google_storage_bucket.lacework_bucket[0].name
}

// IAM Configuration

// Lacework Service Account to access Object Storage
module "lacework_agentless_scan_svc_account" {
  count = var.global ? 1 : 0

  source               = "lacework/service-account/gcp"
  version              = "~> 1.0"
  create               = true
  service_account_name = local.service_account_name
  project_id           = local.project_id
}

resource "google_project_iam_member" "lacework_svc_account" {
  for_each = local.service_account_permissions

  project = local.project_id
  role    = each.key
  member  = "serviceAccount:${local.service_account_json_key.client_email}"
}

// Service Account for Orchestration
resource "google_service_account" "agentless_orchestrate" {
  count = var.global ? 1 : 0

  account_id   = "${var.prefix}-orchestrate-${local.suffix}"
  description  = "Cloud Run service account for Lacework Agentless Workload Scanning orchestration"
  display_name = "${var.prefix}-orchestrate-${local.suffix}"
  project      = local.project_id

  depends_on = [google_project_service.required_apis]
}

// Organization Role for Snapshot Creation
resource "google_organization_iam_custom_role" "agentless_orchestrate" {
  count = var.global && (var.integration_type == "ORGANIZATION") ? 1 : 0

  role_id = "${var.prefix}-org-snapshot-${local.suffix}"
  org_id  = var.organization_id
  title   = "Lacework Agentless Workload Scanning Role (Organization Snapshots)"
  permissions = [
    "compute.disks.createSnapshot",
    "compute.disks.get",
    "compute.instances.get",
    "compute.instances.list",
    "compute.projects.get",
    "compute.zones.list",
  ]
}

// Service Account <-> Role Binding
resource "google_organization_iam_member" "agentless_orchestrate" {
  count = var.global && (var.integration_type == "ORGANIZATION") ? 1 : 0

  org_id = var.organization_id
  role   = google_organization_iam_custom_role.agentless_orchestrate[0].id
  member = "serviceAccount:${local.agentless_orchestrate_service_account_email}"
}

// Role for Scanner Creation
resource "google_project_iam_custom_role" "agentless_orchestrate" {
  count = var.global ? 1 : 0

  project = local.project_id
  role_id = replace("${var.prefix}-orchestrate-${local.suffix}", "-", "_")
  title   = "Lacework Agentless Workload Scanning Role (Create Scanners)"
  permissions = [
    "compute.instances.create",
    "compute.instances.setIamPolicy",
    "compute.instances.delete",
    "compute.snapshots.create",
    "compute.snapshots.delete",
    "compute.snapshots.list",
    "compute.snapshots.setLabels",
    "compute.snapshots.useReadOnly",
  ]
}

// Service Account <-> Role Binding
resource "google_project_iam_member" "agentless_orchestrate" {
  count = var.global ? 1 : 0

  project = local.project_id
  role    = google_project_iam_custom_role.agentless_orchestrate[0].id
  member  = "serviceAccount:${local.agentless_orchestrate_service_account_email}"
}

// Role for Snapshot Creation
resource "google_project_iam_custom_role" "agentless_orchestrate_project" {
  for_each = setunion([local.project_id], local.included_projects)

  project = each.key
  role_id = replace("${var.prefix}-snapshot-${local.suffix}", "-", "_")
  title   = "Lacework Agentless Workload Scanning Role (Create Snapshots)"
  permissions = [
    "compute.disks.createSnapshot",
    "compute.disks.get",
    "compute.instances.get",
    "compute.instances.list",
    "compute.zones.list",
  ]
}

// Service Account <-> Role Binding
resource "google_project_iam_member" "agentless_orchestrate_project" {
  for_each = google_project_iam_custom_role.agentless_orchestrate_project

  project = split("/", each.value.id)[1]
  role    = each.value.id
  member  = "serviceAccount:${local.agentless_orchestrate_service_account_email}"
}

// Role for Cloud Run invocation
resource "google_project_iam_member" "agentless_orchestrate_invoker" {
  count = var.global ? 1 : 0

  project = local.project_id
  role    = "roles/run.invoker"
  member  = "serviceAccount:${local.agentless_orchestrate_service_account_email}"
}

// Service Account for Scanners
resource "google_service_account" "agentless_scan" {
  count = var.global ? 1 : 0

  account_id   = "${var.prefix}-scanner-${local.suffix}"
  description  = "Compute service account for Lacework Agentless Workload Scanning"
  display_name = "${var.prefix}-scanner-${local.suffix}"
  project      = local.project_id

  depends_on = [google_project_service.required_apis]
}

// Role for Scanners to interact with snapshots
resource "google_project_iam_custom_role" "agentless_scan" {
  count = var.global ? 1 : 0

  project = local.project_id
  role_id = replace("${var.prefix}-scanner-${local.suffix}", "-", "_")
  title   = "Lacework Agentless Workload Scanning Role (Scanner)"
  permissions = [
    "compute.snapshots.delete",
    "compute.snapshots.list",
    "compute.snapshots.setLabels",
    "compute.snapshots.useReadOnly",
  ]
}

// Service Account <-> Role Binding
resource "google_project_iam_member" "agentless_scan" {
  count = var.global ? 1 : 0

  project = local.project_id
  role    = google_project_iam_custom_role.agentless_scan[0].id
  member  = "serviceAccount:${local.agentless_scan_service_account_email}"
}

// Regional - The following are resources created once per Google Cloud region
// Only create regional resources if regional variable is set to true
// count = var.regional ? 1 : 0

// Cloud Run service for Agentless Workload Scanning
resource "google_cloud_run_service" "agentless_orchestrate" {
  count = var.regional ? 1 : 0

  name     = "${var.prefix}-service-${local.suffix}"
  location = var.region
  project  = local.project_id

  template {
    spec {
      containers {
        image = var.image_url
      }
      container_concurrency = 1
      service_account_name  = local.agentless_orchestrate_service_account_email
      timeout_seconds       = 3600
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  metadata {
    labels = merge(var.labels)
    annotations = {
      "run.googleapis.com/ingress" : "all"
    }
  }

  depends_on = [google_project_service.required_apis]
}

data "google_compute_default_service_account" "default" {
  project = local.project_id

  depends_on = [google_project_service.required_apis]
}

// Cloud Scheduler job to periodically trigger Cloud Run
resource "google_cloud_scheduler_job" "agentless_orchestrate" {
  count = var.regional ? 1 : 0

  name        = "${var.prefix}-periodic-trigger-${local.suffix}"
  description = "Invoke Lacework Agentless Workload Scanning on a schedule."
  project     = local.project_id
  region      = var.region
  schedule    = "0 * * * *"
  time_zone   = "Etc/UTC"

  http_target {
    http_method = "POST"
    uri         = google_cloud_run_service.agentless_orchestrate[0].status[0].url

    oidc_token {
      audience              = "${google_cloud_run_service.agentless_orchestrate[0].status[0].url}/"
      service_account_email = data.google_compute_default_service_account.default.email
    }
  }

  depends_on = [google_project_service.required_apis]
}
