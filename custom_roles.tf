
// Scope : MONITORED_PROJECT
// Use	 : Enumerate Instances & Access Disks in Monitored projects for Clone creation
// Role created in each monitored project
resource "google_project_iam_custom_role" "agentless_orchestrate_monitored_project" {
  for_each = var.global && (var.integration_type == "PROJECT") ? setunion([local.scanning_project_id], local.included_projects) : []

  project = each.key
  role_id = replace("${var.prefix}-snapshot-${local.suffix}", "-", "_")
  title   = "Lacework Agentless Workload Scanning Role for monitored project (Create Snapshots)"
  permissions = [
    "compute.disks.get",
    "compute.disks.useReadOnly",
    "compute.instances.get",
    "compute.instances.list",
    "compute.machineTypes.get",
    "compute.zones.list",
    "resourcemanager.projects.get",
  ]
}

// Scope : MONITORED_PROJECT
// Use	 : Accessing Folders/Organizations for Resource Group v2
// Role created at organization
// Note this binding happens at the organization level because the custom role requires organization level permissions
resource "google_organization_iam_custom_role" "agentless_orchestrate_monitored_project_resource_group" {
  count = var.global && (var.integration_type == "PROJECT") ? 1 : 0

  org_id  = local.organization_id
  role_id = replace("${var.prefix}-resource-group-${local.suffix}", "-", "_")
  title   = "Lacework Agentless Workload Scanning Role for monitored project (Resource Group)"
  permissions = [
    "resourcemanager.folders.get",
    "resourcemanager.organizations.get",
  ]
}

//-----------------------------------------------------------------------------------

// Scope : MONITORED_ORGANIZATION
// Use	 : Enumerate Instances & Access Disks in Organization for Clone creation
// Role created at organization
resource "google_organization_iam_custom_role" "agentless_orchestrate" {
  count = var.global && (var.integration_type == "ORGANIZATION") ? 1 : 0

  role_id = replace("${var.prefix}-snapshot-${local.suffix}", "-", "_")
  org_id  = local.organization_id
  title   = "Lacework Agentless Workload Scanning Role for monitored organization (Organization Snapshots)"
  permissions = [
    "iam.roles.get",
    "compute.disks.get",
    "compute.disks.useReadOnly",
    "compute.instances.get",
    "compute.instances.list",
    "compute.machineTypes.get",
    "compute.projects.get",
    "compute.zones.list",
    "resourcemanager.folders.list",
    "resourcemanager.projects.list",
    // Required for Resource Group v2
    "resourcemanager.organizations.get",
    "resourcemanager.folders.get",
    "resourcemanager.projects.get",
  ]
}

//-----------------------------------------------------------------------------------

// Scope : SCANNER_PROJECT
// Use	 : Create & Delete resources in scanner project
resource "google_project_iam_custom_role" "agentless_orchestrate" {
  count = var.global ? 1 : 0

  project = local.scanning_project_id
  role_id = replace("${var.prefix}-orchestrate-${local.suffix}", "-", "_")
  title   = "Lacework Agentless Workload Scanning Role (Cloud Run Jobs)"
  permissions = [
    "compute.disks.create",
    "compute.disks.delete",
    "compute.disks.list",
    "compute.disks.setLabels",
    "compute.disks.use",
    "compute.instances.create",
    "compute.instances.setIamPolicy",
    "compute.instances.list",
    "compute.instances.delete",
    "compute.instances.list",
    "compute.instances.setMetadata",
    "compute.instances.setServiceAccount",
    "compute.machineTypes.get",
    "compute.snapshots.create",
    "compute.snapshots.delete",
    "compute.snapshots.list",
    "compute.snapshots.setLabels",
    "compute.snapshots.useReadOnly",
    "compute.subnetworks.use",
    "compute.subnetworks.useExternalIp",
    "compute.zoneOperations.get",
    "storage.objects.list",
    "storage.objects.create",
    "storage.objects.delete",
    "storage.objects.get",
  ]
}

//-----------------------------------------------------------------------------------

// Scope : SCANNER_PROJECT
// Use	 : Create & Delete resources in scanner project
// Role for Scanner Instances to interact with resources in Scanner project
resource "google_project_iam_custom_role" "agentless_scan" {
  count = var.global ? 1 : 0

  project = local.scanning_project_id
  role_id = replace("${var.prefix}-scanner-${local.suffix}", "-", "_")
  title   = "Lacework Agentless Workload Scanning Role (Scanner Instance)"
  permissions = [
    "compute.disks.create",
    "compute.disks.get",
    "compute.instances.create",
    "compute.instances.delete",
    "compute.snapshots.delete",
    "compute.snapshots.list",
    "compute.snapshots.setLabels",
    "compute.snapshots.useReadOnly",
  ]
}


