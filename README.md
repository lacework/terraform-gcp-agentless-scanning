<a href="https://lacework.com"><img src="https://techally-content.s3-us-west-1.amazonaws.com/public-content/lacework_logo_full.png" width="600"></a>

# terraform-gcp-agentless-scanning

[![GitHub release](https://img.shields.io/github/release/lacework/terraform-<PROVIDER>-<NAME>.svg)](https://github.com/lacework/terraform-gcp-agentless-scanning/releases/)
[![Codefresh build status]( https://g.codefresh.io/api/badges/pipeline/lacework/terraform-modules%2Ftest-compatibility?type=cf-1&key=eyJhbGciOiJIUzI1NiJ9.NWVmNTAxOGU4Y2FjOGQzYTkxYjg3ZDEx.RJ3DEzWmBXrJX7m38iExJ_ntGv4_Ip8VTa-an8gBwBo)]( https://g.codefresh.io/pipelines/edit/new/builds?id=607e25e6728f5a6fba30431b&pipeline=test-compatibility&projects=terraform-modules&projectId=607db54b728f5a5f8930405d)

A Terraform Module to configure the Lacework Agentless Scanner.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.31 |
| <a name="requirement_lacework"></a> [lacework](#requirement\_lacework) | ~> 0.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.36.0 |
| <a name="provider_lacework"></a> [lacework](#provider\_lacework) | 0.25.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lacework_agentless_scan_svc_account"></a> [lacework\_agentless\_scan\_svc\_account](#module\_lacework\_agentless\_scan\_svc\_account) | lacework/service-account/gcp | ~> 1.0 |

## Resources

| Name | Type |
|------|------|
| [google_cloud_run_service.agentless_scan](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service) | resource |
| [google_cloud_scheduler_job.agentless_scan](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_scheduler_job) | resource |
| [google_organization_iam_custom_role.agentless_scan](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_custom_role) | resource |
| [google_organization_iam_member.agentless_scan](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_project_iam_custom_role.agentless_scan](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_member.agentless_scan](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.invoker](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.lacework_svc_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_service.required_apis](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_account.agentless_scan](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_storage_bucket.lacework_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_binding.policies](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_binding) | resource |
| [random_id.uniq](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [google_compute_default_service_account.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_default_service_account) | data source |
| [google_project.selected](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |
| [lacework_user_profile.current](https://registry.terraform.io/providers/lacework/lacework/latest/docs/data-sources/user_profile) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agentless_scan_service_account_email"></a> [agentless\_scan\_service\_account\_email](#input\_agentless\_scan\_service\_account\_email) | The email of the service account for which to use during scan tasks. | `string` | `""` | no |
| <a name="input_bucket_enable_ubla"></a> [bucket\_enable\_ubla](#input\_bucket\_enable\_ubla) | Boolean for enabling Uniform Bucket Level Access on the created bucket.  Default is `true`. | `bool` | `true` | no |
| <a name="input_bucket_force_destroy"></a> [bucket\_force\_destroy](#input\_bucket\_force\_destroy) | Force destroy bucket (Required when bucket not empty) | `bool` | `true` | no |
| <a name="input_bucket_lifecycle_rule_age"></a> [bucket\_lifecycle\_rule\_age](#input\_bucket\_lifecycle\_rule\_age) | Number of days to keep agentless scan objects in bucket before deletion. | `number` | `30` | no |
| <a name="input_global"></a> [global](#input\_global) | Whether or not to create global resources. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_image_url"></a> [image\_url](#input\_image\_url) | The container image url for Lacework Agentless Workload Scanning. | `string` | `"TODO: Must be defined as Google Repo"` | no |
| <a name="input_integration_type"></a> [integration\_type](#input\_integration\_type) | Specify the integration type. Can only be PROJECT or ORGANIZATION. Defaults to PROJECT | `string` | `"PROJECT"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Set of labels which will be added to the resources managed by the module. | `map(string)` | `{}` | no |
| <a name="input_lacework_account"></a> [lacework\_account](#input\_lacework\_account) | The name of the Lacework account with which to integrate. | `string` | `""` | no |
| <a name="input_lacework_domain"></a> [lacework\_domain](#input\_lacework\_domain) | The domain of the Lacework account with with to integrate. | `string` | `"lacework.net"` | no |
| <a name="input_lacework_integration_name"></a> [lacework\_integration\_name](#input\_lacework\_integration\_name) | The name of the Lacework cloud account integration. | `string` | `"google-cloud-agentless-scanning"` | no |
| <a name="input_organization_id"></a> [organization\_id](#input\_organization\_id) | The organization ID, required if integration\_type is set to ORGANIZATION | `string` | `""` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | A string to be prefixed to the name of all new resources. | `string` | `"lacework-awls"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | A project ID different from the default defined inside the provider | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | The region in which to create resources. | `string` | `"us-central1"` | no |
| <a name="input_regional"></a> [regional](#input\_regional) | Whether or not to create regional resources. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_required_apis"></a> [required\_apis](#input\_required\_apis) | n/a | `map(any)` | <pre>{<br>  "cloudscheduler": "cloudscheduler.googleapis.com",<br>  "compute": "compute.googleapis.com",<br>  "iam": "iam.googleapis.com",<br>  "run": "run.googleapis.com"<br>}</pre> | no |
| <a name="input_scan_containers"></a> [scan\_containers](#input\_scan\_containers) | Whether to includes scanning for containers.  Defaults to `true`. | `bool` | `true` | no |
| <a name="input_scan_frequency_hours"></a> [scan\_frequency\_hours](#input\_scan\_frequency\_hours) | How often in hours the scan will run in hours. Defaults to `24`. | `number` | `24` | no |
| <a name="input_scan_host_vulnerabilities"></a> [scan\_host\_vulnerabilities](#input\_scan\_host\_vulnerabilities) | Whether to includes scanning for host vulnerabilities.  Defaults to `true`. | `bool` | `true` | no |
| <a name="input_service_account_name"></a> [service\_account\_name](#input\_service\_account\_name) | The name of the service account Lacework will use to access scan results. | `string` | `""` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | A string to be appended to the end of the name of all new resources. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_agentless_scan_ecs_task_role_arn"></a> [agentless\_scan\_ecs\_task\_role\_arn](#output\_agentless\_scan\_ecs\_task\_role\_arn) | Output Cloud Run service account email. |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | The storage bucket name for Agentless Workload Scanning data. |
| <a name="output_service_account_name"></a> [service\_account\_name](#output\_service\_account\_name) | The service account name for Lacework. |
| <a name="output_service_account_private_key"></a> [service\_account\_private\_key](#output\_service\_account\_private\_key) | The base64 encoded private key in JSON format for Lacework. |
