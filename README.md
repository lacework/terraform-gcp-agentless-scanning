<a href="https://lacework.com"><img src="https://techally-content.s3-us-west-1.amazonaws.com/public-content/lacework_logo_full.png" width="600"></a>

# terraform-gcp-agentless-scanning

[![GitHub release](https://img.shields.io/github/release/lacework/terraform-gcp-agentless-scanning.svg)](https://github.com/lacework/terraform-gcp-agentless-scanning/releases/)
[![Codefresh build status](https://g.codefresh.io/api/badges/pipeline/lacework/terraform-modules%2Ftest-compatibility?type=cf-1&key=eyJhbGciOiJIUzI1NiJ9.NWVmNTAxOGU4Y2FjOGQzYTkxYjg3ZDEx.RJ3DEzWmBXrJX7m38iExJ_ntGv4_Ip8VTa-an8gBwBo)](https://g.codefresh.io/pipelines/edit/new/builds?id=607e25e6728f5a6fba30431b&pipeline=test-compatibility&projects=terraform-modules&projectId=607db54b728f5a5f8930405d)

A Terraform Module to configure the Lacework Agentless Scanner.
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.31 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.46 |
| <a name="requirement_lacework"></a> [lacework](#requirement\_lacework) | ~> 1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 4.46 |
| <a name="provider_lacework"></a> [lacework](#provider\_lacework) | ~> 1.3 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lacework_agentless_scan_svc_account"></a> [lacework\_agentless\_scan\_svc\_account](#module\_lacework\_agentless\_scan\_svc\_account) | lacework/service-account/gcp | ~> 1.0 |

## Resources

| Name | Type |
|------|------|
| [google_cloud_run_v2_job.agentless_orchestrate](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_v2_job) | resource |
| [google_cloud_scheduler_job.agentless_orchestrate](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_scheduler_job) | resource |
| [google_organization_iam_custom_role.agentless_orchestrate](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_custom_role) | resource |
| [google_organization_iam_member.agentless_orchestrate](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_project_iam_custom_role.agentless_orchestrate](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.agentless_orchestrate_monitored_project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.agentless_scan](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_member.agentless_orchestrate](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.agentless_orchestrate_invoker](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.agentless_orchestrate_monitored_project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.agentless_orchestrate_service_account_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.agentless_scan](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.lacework_svc_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_service.required_apis](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_secret_manager_secret.agentless_orchestrate](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_iam_member.member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_iam_member) | resource |
| [google_secret_manager_secret_version.agentless_orchestrate](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_service_account.agentless_orchestrate](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.agentless_scan](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_storage_bucket.lacework_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_binding.lacework_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_binding) | resource |
| [lacework_integration_gcp_agentless_scanning.lacework_cloud_account](https://registry.terraform.io/providers/lacework/lacework/latest/docs/resources/integration_gcp_agentless_scanning) | resource |
| [random_id.uniq](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
| [google_compute_default_service_account.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_default_service_account) | data source |
| [google_project.selected](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |
| [lacework_user_profile.current](https://registry.terraform.io/providers/lacework/lacework/latest/docs/data-sources/user_profile) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agentless_orchestrate_service_account_email"></a> [agentless\_orchestrate\_service\_account\_email](#input\_agentless\_orchestrate\_service\_account\_email) | The email of the service account for which to use during scan tasks. | `string` | `""` | no |
| <a name="input_agentless_scan_secret_id"></a> [agentless\_scan\_secret\_id](#input\_agentless\_scan\_secret\_id) | The ID of the Google Secret containing the Lacework Account and Auth Token | `string` | `""` | no |
| <a name="input_agentless_scan_service_account_email"></a> [agentless\_scan\_service\_account\_email](#input\_agentless\_scan\_service\_account\_email) | The email of the service account for which to use during scan tasks. | `string` | `""` | no |
| <a name="input_bucket_enable_ubla"></a> [bucket\_enable\_ubla](#input\_bucket\_enable\_ubla) | Boolean for enabling Uniform Bucket Level Access on the created bucket.  Default is `true`. | `bool` | `true` | no |
| <a name="input_bucket_force_destroy"></a> [bucket\_force\_destroy](#input\_bucket\_force\_destroy) | Force destroy bucket (if disabled, terraform will not be able to destroy non-empty bucket) | `bool` | `true` | no |
| <a name="input_bucket_lifecycle_rule_age"></a> [bucket\_lifecycle\_rule\_age](#input\_bucket\_lifecycle\_rule\_age) | Number of days to keep agentless scan objects in bucket before deletion. | `number` | `30` | no |
| <a name="input_custom_vpc_subnet"></a> [custom\_vpc\_subnet](#input\_custom\_vpc\_subnet) | The name of the custom Google Cloud VPC subnet to use for scanning compute resources | `string` | `""` | no |
| <a name="input_global"></a> [global](#input\_global) | Whether or not to create global resources. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_global_module_reference"></a> [global\_module\_reference](#input\_global\_module\_reference) | A reference to the global lacework\_gcp\_agentless\_scanning module for this account. | <pre>object({<br>    agentless_orchestrate_service_account_email = string<br>    agentless_scan_service_account_email        = string<br>    agentless_scan_secret_id                    = string<br>    lacework_account                            = string<br>    lacework_domain                             = string<br>    prefix                                      = string<br>    suffix                                      = string<br>  })</pre> | <pre>{<br>  "agentless_orchestrate_service_account_email": "",<br>  "agentless_scan_secret_id": "",<br>  "agentless_scan_service_account_email": "",<br>  "lacework_account": "",<br>  "lacework_domain": "",<br>  "prefix": "",<br>  "suffix": ""<br>}</pre> | no |
| <a name="input_image_url"></a> [image\_url](#input\_image\_url) | The container image url for Lacework Agentless Workload Scanning. | `string` | `"us-docker.pkg.dev/agentless-sidekick-images-tl48/sidekick/sidekick"` | no |
| <a name="input_integration_type"></a> [integration\_type](#input\_integration\_type) | Specify the integration type. Can only be PROJECT or ORGANIZATION. Defaults to PROJECT | `string` | `"PROJECT"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Set of labels which will be added to the resources managed by the module. | `map(string)` | `{}` | no |
| <a name="input_lacework_account"></a> [lacework\_account](#input\_lacework\_account) | The name of the Lacework account with which to integrate. | `string` | `""` | no |
| <a name="input_lacework_domain"></a> [lacework\_domain](#input\_lacework\_domain) | The domain of the Lacework account with with to integrate. | `string` | `"lacework.net"` | no |
| <a name="input_lacework_integration_name"></a> [lacework\_integration\_name](#input\_lacework\_integration\_name) | The name of the Lacework cloud account integration. | `string` | `"google-cloud-agentless-scanning"` | no |
| <a name="input_lacework_integration_service_account_name"></a> [lacework\_integration\_service\_account\_name](#input\_lacework\_integration\_service\_account\_name) | The name of the service account Lacework will use to access scan results. | `string` | `""` | no |
| <a name="input_organization_id"></a> [organization\_id](#input\_organization\_id) | The organization ID, required if integration\_type is set to ORGANIZATION | `string` | `""` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | A string to be prefixed to the name of all new resources. | `string` | `"lacework-awls"` | no |
| <a name="input_project_filter_list"></a> [project\_filter\_list](#input\_project\_filter\_list) | A list of projects to include/exclude for integration. | `list(any)` | `[]` | no |
| <a name="input_regional"></a> [regional](#input\_regional) | Whether or not to create regional resources. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_required_apis"></a> [required\_apis](#input\_required\_apis) | n/a | `map(any)` | <pre>{<br>  "cloudscheduler": "cloudscheduler.googleapis.com",<br>  "compute": "compute.googleapis.com",<br>  "iam": "iam.googleapis.com",<br>  "run": "run.googleapis.com",<br>  "secretmanager": "secretmanager.googleapis.com"<br>}</pre> | no |
| <a name="input_scan_containers"></a> [scan\_containers](#input\_scan\_containers) | Whether to includes scanning for containers.  Defaults to `true`. | `bool` | `true` | no |
| <a name="input_scan_frequency_hours"></a> [scan\_frequency\_hours](#input\_scan\_frequency\_hours) | How often in hours the scan will run in hours. Defaults to `24`. | `number` | `24` | no |
| <a name="input_scan_host_vulnerabilities"></a> [scan\_host\_vulnerabilities](#input\_scan\_host\_vulnerabilities) | Whether to includes scanning for host vulnerabilities.  Defaults to `true`. | `bool` | `true` | no |
| <a name="input_scan_multi_volume"></a> [scan\_multi\_volume](#input\_scan\_multi\_volume) | Whether to scan secondary volumes. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_scan_stopped_instances"></a> [scan\_stopped\_instances](#input\_scan\_stopped\_instances) | Whether to scan stopped instances. Defaults to `false`. | `bool` | `true` | no |
| <a name="input_scanning_project_id"></a> [scanning\_project\_id](#input\_scanning\_project\_id) | A project ID different from the default defined inside the provider - used for scanning resources | `string` | `""` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | A string to be appended to the end of the name of all new resources. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_agentless_orchestrate_service_account_email"></a> [agentless\_orchestrate\_service\_account\_email](#output\_agentless\_orchestrate\_service\_account\_email) | Output Cloud Run service account email. |
| <a name="output_agentless_scan_secret_id"></a> [agentless\_scan\_secret\_id](#output\_agentless\_scan\_secret\_id) | Google Secret Manager ID for Lacework Account and Token. |
| <a name="output_agentless_scan_service_account_email"></a> [agentless\_scan\_service\_account\_email](#output\_agentless\_scan\_service\_account\_email) | Output Compute service account email. |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | The storage bucket name for Agentless Workload Scanning data. |
| <a name="output_lacework_account"></a> [lacework\_account](#output\_lacework\_account) | Lacework Account Name for Integration. |
| <a name="output_lacework_domain"></a> [lacework\_domain](#output\_lacework\_domain) | Lacework Domain Name for Integration. |
| <a name="output_prefix"></a> [prefix](#output\_prefix) | Prefix used to add uniqueness to resource names. |
| <a name="output_service_account_name"></a> [service\_account\_name](#output\_service\_account\_name) | The service account name for Lacework. |
| <a name="output_service_account_private_key"></a> [service\_account\_private\_key](#output\_service\_account\_private\_key) | The base64 encoded private key in JSON format for Lacework. |
| <a name="output_suffix"></a> [suffix](#output\_suffix) | Suffix used to add uniqueness to resource names. |
<!-- END_TF_DOCS -->