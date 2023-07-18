variable "required_apis" {
  type = map(any)
  default = {
    cloudscheduler = "cloudscheduler.googleapis.com"
    compute        = "compute.googleapis.com"
    iam            = "iam.googleapis.com"
    run            = "run.googleapis.com"
    secretmanager  = "secretmanager.googleapis.com"
  }
}

variable "integration_type" {
  type        = string
  default     = "PROJECT"
  description = "Specify the integration type. Can only be PROJECT or ORGANIZATION. Defaults to PROJECT"
  validation {
    condition     = contains(["PROJECT", "ORGANIZATION"], var.integration_type)
    error_message = "The integration_type must be either PROJECT or ORGANIZATION."
  }
}

variable "organization_id" {
  type        = string
  default     = ""
  description = "The organization ID, required if integration_type is set to ORGANIZATION"
}

variable "scanning_project_id" {
  type        = string
  default     = ""
  description = "A project ID different from the default defined inside the provider - used for scanning resources"
  validation {
    condition     = can(regex("(^[a-z][a-z0-9_-]{6,30}[^-]$|^$)", var.scanning_project_id))
    error_message = "The project_id variable must be a valid GCP project ID. It must be 6 to 30 lowercase ASCII letters, digits, or hyphens. It must start with a letter. Trailing hyphens are prohibited.. Example: tokyo-rain-123."
  }
}

variable "project_filter_list" {
  type        = list(any)
  default     = []
  description = "A list of projects to include/exclude for integration."
}

variable "prefix" {
  type        = string
  description = "A string to be prefixed to the name of all new resources."
  default     = "lacework-awls"

  validation {
    condition     = length(regexall(".*lacework.*", var.prefix)) > 0
    error_message = "The prefix value must include the term 'lacework'."
  }
}

variable "suffix" {
  type        = string
  description = "A string to be appended to the end of the name of all new resources."
  default     = ""

  validation {
    condition     = length(var.suffix) == 0 || length(var.suffix) > 4
    error_message = "If the suffix value is set then it must be at least 4 characters long."
  }
}

variable "lacework_integration_name" {
  type        = string
  description = "The name of the Lacework cloud account integration."
  default     = "google-cloud-agentless-scanning"
}

variable "lacework_account" {
  type        = string
  description = "The name of the Lacework account with which to integrate."
  default     = ""
}

variable "lacework_domain" {
  type        = string
  description = "The domain of the Lacework account with with to integrate."
  default     = "lacework.net"
}

variable "scan_containers" {
  type        = bool
  description = "Whether to includes scanning for containers.  Defaults to `true`."
  default     = true
}

variable "scan_host_vulnerabilities" {
  type        = bool
  description = "Whether to includes scanning for host vulnerabilities.  Defaults to `true`."
  default     = true
}

variable "scan_multi_volume" {
  type = bool
  description = "Whether to scan secondary volumes. Defaults to `false`."
  default = false
}

variable "scan_stopped_instances" {
  type = bool
  description = "Whether to scan stopped instances. Defaults to `false`."
  default = true
}

variable "scan_frequency_hours" {
  type        = number
  description = "How often in hours the scan will run in hours. Defaults to `24`."
  default     = 24
  
  validation {
    condition = ( 
      var.scan_frequency_hours == 24 || 
      var.scan_frequency_hours == 12 || 
      var.scan_frequency_hours == 6
    )
    error_message = "The scan frequency must be 6, 12, or 24 hours."
  }
}

variable "agentless_scan_secret_id" {
  type        = string
  description = "The ID of the Google Secret containing the Lacework Account and Auth Token"
  default     = ""
}

variable "image_url" {
  type        = string
  description = "The container image url for Lacework Agentless Workload Scanning."
  default     = "us-docker.pkg.dev/agentless-sidekick-images-tl48/sidekick/sidekick"
}

variable "global" {
  type        = bool
  default     = false
  description = "Whether or not to create global resources. Defaults to `false`."
}

variable "regional" {
  type        = bool
  default     = false
  description = "Whether or not to create regional resources. Defaults to `false`."
}

variable "agentless_orchestrate_service_account_email" {
  type        = string
  default     = ""
  description = "The email of the service account for which to use during scan tasks."
}

variable "agentless_scan_service_account_email" {
  type        = string
  default     = ""
  description = "The email of the service account for which to use during scan tasks."
}

variable "bucket_enable_ubla" {
  description = "Boolean for enabling Uniform Bucket Level Access on the created bucket.  Default is `true`."
  type        = bool
  default     = true
}

variable "bucket_force_destroy" {
  type        = bool
  default     = true
  description = "Force destroy bucket (Required when bucket not empty)"
}

variable "bucket_lifecycle_rule_age" {
  type        = number
  default     = 30
  description = "Number of days to keep agentless scan objects in bucket before deletion."
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Set of labels which will be added to the resources managed by the module."
}

variable "lacework_integration_service_account_name" {
  type        = string
  default     = ""
  description = "The name of the service account Lacework will use to access scan results."
}

variable "custom_vpc_subnet" {
  type        = string
  default     = ""
  description = "The name of the custom Google Cloud VPC subnet to use for scanning compute resources"
}

variable "global_module_reference" {
  type = object({
    agentless_orchestrate_service_account_email = string
    agentless_scan_service_account_email        = string
    agentless_scan_secret_id                    = string
    lacework_account                            = string
    lacework_domain                             = string
    prefix                                      = string
    suffix                                      = string
  })
  default = {
    agentless_orchestrate_service_account_email = ""
    agentless_scan_service_account_email        = ""
    agentless_scan_secret_id                    = ""
    lacework_account                            = ""
    lacework_domain                             = ""
    prefix                                      = ""
    suffix                                      = ""
  }
  description = "A reference to the global lacework_gcp_agentless_scanning module for this account."
}
