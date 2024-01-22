locals {
  scanning_project_id = length(var.scanning_project_id) > 0 ? var.scanning_project_id : data.google_project.selected[0].project_id
  organization_id     = length(var.organization_id) > 0 ? var.organization_id : (data.google_project.selected[0].org_id != null ? data.google_project.selected[0].org_id : "")

  agentless_orchestrate_service_account_email = var.global ? google_service_account.agentless_orchestrate[0].email : (length(var.global_module_reference.agentless_orchestrate_service_account_email) > 0 ? var.global_module_reference.agentless_orchestrate_service_account_email : var.agentless_orchestrate_service_account_email)
  agentless_scan_service_account_email        = var.global ? google_service_account.agentless_scan[0].email : (length(var.global_module_reference.agentless_scan_service_account_email) > 0 ? var.global_module_reference.agentless_scan_service_account_email : var.agentless_scan_service_account_email)
  agentless_scan_secret_id                    = var.global ? google_secret_manager_secret.agentless_orchestrate[0].id : (length(var.global_module_reference.agentless_scan_secret_id) > 0 ? var.global_module_reference.agentless_scan_secret_id : var.agentless_scan_secret_id)

  lacework_domain  = length(var.global_module_reference.lacework_domain) > 0 ? var.global_module_reference.lacework_domain : var.lacework_domain
  lacework_account = length(var.global_module_reference.lacework_account) > 0 ? var.global_module_reference.lacework_account : (length(var.lacework_account) > 0 ? var.lacework_account : trimsuffix(data.lacework_user_profile.current.url, ".${local.lacework_domain}"))

  suffix = length(var.global_module_reference.suffix) > 0 ? var.global_module_reference.suffix : (length(var.suffix) > 0 ? var.suffix : random_id.uniq.hex)
  prefix = length(var.global_module_reference.prefix) > 0 ? var.global_module_reference.prefix : var.prefix

  region = data.google_client_config.default.region

  lacework_integration_service_account_name     = var.global ? (length(var.lacework_integration_service_account_name) > 0 ? var.lacework_integration_service_account_name : "${var.prefix}-sa-${local.suffix}") : ""
  lacework_integration_service_account_json_key = var.global ? jsondecode(base64decode(module.lacework_agentless_scan_svc_account[0].private_key)) : jsondecode("{}")
  lacework_integration_service_account_permissions = var.global ? toset([
    "roles/storage.objectViewer",
    "roles/run.invoker",
  ]) : []

  included_projects = var.global ? toset([for project in var.project_filter_list : project if !(substr(project, 0, 1) == "-")]) : []
  excluded_projects = var.global ? toset([for project in var.project_filter_list : project if substr(project, 0, 1) == "-"]) : []

  bucket_name = "${var.prefix}-bucket-${local.suffix}"
  bucket_roles = var.global ? ({
    "roles/storage.admin" = [
      "projectEditor:${local.scanning_project_id}",
      "projectOwner:${local.scanning_project_id}"
    ],
    "roles/storage.objectAdmin" = [
      "serviceAccount:${local.agentless_orchestrate_service_account_email}",
      "serviceAccount:${local.agentless_scan_service_account_email}"
    ],
    "roles/storage.objectViewer" = [
      "serviceAccount:${local.lacework_integration_service_account_json_key.client_email}",
      "projectViewer:${local.scanning_project_id}"
    ]
  }) : ({})

  version_file   = "${abspath(path.module)}/VERSION"
  module_name    = basename(abspath(path.module))
  module_version = fileexists(local.version_file) ? file(local.version_file) : ""
}

resource "random_id" "uniq" {
  byte_length = 2
}

data "lacework_user_profile" "current" {}

data "google_client_config" "default" {}

data "google_project" "selected" {
  count = length(var.scanning_project_id) > 0 ? (length(var.organization_id) > 0 ? 0 : 1) : 1
}

resource "google_project_service" "required_apis" {
  for_each = var.required_apis

  project = local.scanning_project_id
  service = each.value

  disable_on_destroy = false
}

// Global - The following are resources are created once per integration
// includes the lacework cloud account integration
// Only create global resources if global variable is set to true
// count = var.global ? 1 : 0

// Lacework Cloud Account Integration
resource "lacework_integration_gcp_agentless_scanning" "lacework_cloud_account" {
  count = var.global ? 1 : 0

  name                = var.lacework_integration_name
  resource_level      = var.integration_type
  resource_id         = length(local.organization_id) > 0 ? local.organization_id : local.scanning_project_id
  bucket_name         = google_storage_bucket.lacework_bucket[0].name
  scanning_project_id = local.scanning_project_id
  filter_list         = var.project_filter_list
  scan_multi_volume   = var.scan_multi_volume
  scan_stopped_instances = var.scan_stopped_instances
  credentials {
    client_id      = local.lacework_integration_service_account_json_key.client_id
    private_key_id = local.lacework_integration_service_account_json_key.private_key_id
    client_email   = local.lacework_integration_service_account_json_key.client_email
    private_key    = local.lacework_integration_service_account_json_key.private_key
  }
}

// Secret Manager
resource "google_secret_manager_secret" "agentless_orchestrate" {
  count = var.global ? 1 : 0

  secret_id = "${var.prefix}-secret-${local.suffix}"
  project   = local.scanning_project_id

  replication {
    user_managed {
      replicas {
        location = local.region
      }
    }
  }

  labels = merge(var.labels)

  depends_on = [google_project_service.required_apis]
}

resource "google_secret_manager_secret_version" "agentless_orchestrate" {
  count = var.global ? 1 : 0

  secret      = google_secret_manager_secret.agentless_orchestrate[0].id
  secret_data = <<EOF
   {
    "account": "${local.lacework_account}",
    "scanner_service_account": "${local.agentless_scan_service_account_email}",
    "token": "${lacework_integration_gcp_agentless_scanning.lacework_cloud_account[0].server_token}"
   }
EOF
}

resource "google_secret_manager_secret_iam_member" "member" {
  count = var.global ? 1 : 0

  project   = local.scanning_project_id
  secret_id = google_secret_manager_secret.agentless_orchestrate[0].secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${local.agentless_orchestrate_service_account_email}"
}

// Storage Bucket for Analysis Data
resource "google_storage_bucket" "lacework_bucket" {
  count = var.global ? 1 : 0

  project       = local.scanning_project_id
  name          = local.bucket_name
  force_destroy = var.bucket_force_destroy
  location      = local.region

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

//----------------------------------------------------------------------------------------------

// Lacework Integration Service Account to access Object Storage
module "lacework_agentless_scan_svc_account" {
  count = var.global ? 1 : 0

  source               = "lacework/service-account/gcp"
  version              = "~> 1.0"
  create               = true
  service_account_name = local.lacework_integration_service_account_name
  project_id           = local.scanning_project_id
}

// Lacework Integrtion Service Account <-> Role Binding
resource "google_project_iam_member" "lacework_svc_account" {
  for_each = local.lacework_integration_service_account_permissions

  project = local.scanning_project_id
  role    = each.key
  member  = "serviceAccount:${local.lacework_integration_service_account_json_key.client_email}"
}

//----------------------------------------------------------------------------------------------

// Orchestrate Service Account for Enumeration and Clone creation
resource "google_service_account" "agentless_orchestrate" {
  count = var.global ? 1 : 0

  account_id   = "${var.prefix}-orchestrate-${local.suffix}"
  description  = "Cloud Run service account for Lacework Agentless Workload Scanning orchestration"
  display_name = "${var.prefix}-orchestrate-${local.suffix}"
  project      = local.scanning_project_id

  depends_on = [google_project_service.required_apis]
}

// Orchestrate Service Account <-> Role Binding for Custom Role created in Organization
resource "google_organization_iam_member" "agentless_orchestrate" {
  count = var.global && (var.integration_type == "ORGANIZATION") ? 1 : 0

  org_id = var.organization_id
  role   = google_organization_iam_custom_role.agentless_orchestrate[0].id
  member = "serviceAccount:${local.agentless_orchestrate_service_account_email}"
}

// Orchestrate Service Account <-> Role Binding for Custom Role created in each monitored project
resource "google_project_iam_member" "agentless_orchestrate_monitored_project" {
  for_each = google_project_iam_custom_role.agentless_orchestrate_monitored_project

  project = split("/", each.value.id)[1]
  role    = each.value.id
  member  = "serviceAccount:${local.agentless_orchestrate_service_account_email}"
}

// Orchestrate Service Account <-> Role Binding for Custom Role created in Scanner Project
resource "google_project_iam_member" "agentless_orchestrate" {
  count = var.global ? 1 : 0

  project = local.scanning_project_id
  role    = google_project_iam_custom_role.agentless_orchestrate[0].id
  member  = "serviceAccount:${local.agentless_orchestrate_service_account_email}"
}

// Orchestrate Service Account <-> Role Binding for Service Account usage in Scanner Project
resource "google_project_iam_member" "agentless_orchestrate_service_account_user" {
  count = var.global ? 1 : 0

  project = local.scanning_project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${local.agentless_orchestrate_service_account_email}"
}

// Orchestrate Service Account <-> Role Binding for Cloud Run invocation in Scanner Project
resource "google_project_iam_member" "agentless_orchestrate_invoker" {
  count = var.global ? 1 : 0

  project = local.scanning_project_id
  role    = "roles/run.invoker"
  member  = "serviceAccount:${local.agentless_orchestrate_service_account_email}"
}

//----------------------------------------------------------------------------------------------

// Scan Service Account
resource "google_service_account" "agentless_scan" {
  count = var.global ? 1 : 0

  account_id   = "${var.prefix}-scanner-${local.suffix}"
  description  = "Compute service account for Lacework Agentless Workload Scanning"
  display_name = "${var.prefix}-scanner-${local.suffix}"
  project      = local.scanning_project_id

  depends_on = [google_project_service.required_apis]
}

// Scan Service Account <-> Role Binding for Custom Role created in Scanner Project
resource "google_project_iam_member" "agentless_scan" {
  count = var.global ? 1 : 0

  project = local.scanning_project_id
  role    = google_project_iam_custom_role.agentless_scan[0].id
  member  = "serviceAccount:${local.agentless_scan_service_account_email}"
}

//----------------------------------------------------------------------------------------------

// Regional - The following are resources created once per Google Cloud region
// Only create regional resources if regional variable is set to true
// count = var.regional ? 1 : 0

// Cloud Run service for Agentless Workload Scanning
resource "google_cloud_run_v2_job" "agentless_orchestrate" {
  count = var.regional ? 1 : 0

  name         = "${var.prefix}-service-${local.suffix}"
  location     = local.region
  project      = local.scanning_project_id

  template {
    template {
      containers {
        image = var.image_url

        resources {
          limits = {
            cpu    = "4"
            memory = "8Gi"
          }
        }

        env {
          name  = "STARTUP_PROVIDER"
          value = "GCP"
        }
        env {
          name  = "STARTUP_RUNMODE"
          value = "TASK"
        }
        env {
          name  = "LACEWORK_APISERVER"
          value = "${local.lacework_account}.${var.lacework_domain}"
        }
        env {
          name  = "SECRET_ARN"
          value = local.agentless_scan_secret_id
        }
        env {
          name  = "LOCAL_STORAGE"
          value = "/tmp"
        }
        env {
          name  = "STARTUP_SERVICE"
          value = "ORCHESTRATE"
        }
        env {
          name  = "SIDEKICK_BUCKET"
          value = local.bucket_name
        }
        env {
          name  = "SIDEKICK_REGION"
          value = local.region
        }
        env {
          name  = "GCP_SCANNER_PROJECT_ID"
          value = local.scanning_project_id
        }
        env {
          name  = "GCP_ORG_ID"
          value = local.organization_id
        }
        env {
          name  = "GCP_SCAN_SCOPE"
          value = var.integration_type
        }
        env {
          name  = "GCP_SCAN_LIST"
          value = join(", ", var.project_filter_list)
        }
        env {
          name  = "GCP_CUSTOM_SUBNETWORK"
          value = var.custom_vpc_subnet
        }

      }
      service_account = local.agentless_orchestrate_service_account_email
      timeout         = "3600s"
    }
  }

  depends_on = [
    google_project_service.required_apis
  ]
}

data "google_compute_default_service_account" "default" {
  project = local.scanning_project_id

  depends_on = [google_project_service.required_apis]
}

// Cloud Scheduler job to periodically trigger Cloud Run
resource "google_cloud_scheduler_job" "agentless_orchestrate" {
  count = var.regional ? 1 : 0

  name        = "${var.prefix}-periodic-trigger-${local.suffix}"
  description = "Invoke Lacework Agentless Workload Scanning on a schedule."
  project     = local.scanning_project_id
  region      = local.region
  schedule    = "0 * * * *"
  time_zone   = "Etc/UTC"

  http_target {
    http_method = "POST"
    uri         = "https://${local.region}-run.googleapis.com/apis/run.googleapis.com/v1/namespaces/${local.scanning_project_id}/jobs/${var.prefix}-service-${local.suffix}:run"

    oauth_token {
      service_account_email = local.agentless_orchestrate_service_account_email
    }
  }

  depends_on = [google_project_service.required_apis]
}

data "lacework_metric_module" "lwmetrics" {
  name    = local.module_name
  version = local.module_version
}
