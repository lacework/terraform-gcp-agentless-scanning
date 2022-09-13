output "agentless_scan_ecs_task_role_arn" {
  value       = local.agentless_scan_service_account_email
  description = "Output Cloud Run service account email."
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

output "bucket_name" {
  value       = local.bucket_name
  description = "The storage bucket name for Agentless Workload Scanning data."
}
