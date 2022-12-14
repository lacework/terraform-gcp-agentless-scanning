output "agentless_orchestrate_service_account_email" {
  value       = local.agentless_orchestrate_service_account_email
  description = "Output Cloud Run service account email."
}

output "agentless_scan_service_account_email" {
  value       = local.agentless_scan_service_account_email
  description = "Output Compute service account email."
}

output "agentless_scan_secret_id" {
  value       = local.agentless_scan_secret_id
  description = "Google Secret Manager ID for Lacework Account and Token."
}

output "bucket_name" {
  value       = local.bucket_name
  description = "The storage bucket name for Agentless Workload Scanning data."
}

output "lacework_account" {
  value       = local.lacework_account
  description = "Lacework Account Name for Integration."
}

output "lacework_domain" {
  value       = local.lacework_domain
  description = "Lacework Domain Name for Integration."
}

output "prefix" {
  value       = var.prefix
  description = "Prefix used to add uniqueness to resource names."
}

output "service_account_name" {
  value       = local.service_account_name
  description = "The service account name for Lacework."
}

output "service_account_private_key" {
  value       = local.service_account_json_key
  description = "The base64 encoded private key in JSON format for Lacework."
  sensitive   = true
}

output "suffix" {
  value       = local.suffix
  description = "Suffix used to add uniqueness to resource names."
}
