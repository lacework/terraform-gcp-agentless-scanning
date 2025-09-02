check "non_empty_organization_id" {
  // There can be multiple reasons for an empty `organization_id`. One example is that the provider project resides
  // in a folder. In this case, google_project.selected[0].org_id will be empty whereas google_project.selected[0].folder_id
  // will be non-empty. We'd need to ask the user to provide the organization_id in such cases.
  assert {
    condition     = local.organization_id != "" && local.integration_type == "ORGANIZATION"
    error_message = "No `organization_id` is provided and we failed to derive one. Please provide `organization_id`."
  }
}
