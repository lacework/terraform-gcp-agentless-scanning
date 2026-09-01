# Validates the prefix/suffix length guardrails without touching a real cloud.
# Run: terraform init && terraform test
#
# Providers are mocked, so no GCP or Lacework credentials are needed; every
# `run` block below stops at `plan`.

mock_provider "google" {}
mock_provider "lacework" {}
mock_provider "random" {}

# Setting both project and org IDs keeps the plan off the google_project data
# source (which returns nulls under a mock), so it exercises only the naming logic.
variables {
  global              = true
  scanning_project_id = "lacework-test-project"
  organization_id     = "123456789012"
}

# A 4-char suffix lands exactly on GCP's 30-char service account ID limit
# ("lacework-awls" + "-orchestrate-" + "qa01" = 30). This must plan cleanly.
run "suffix_at_limit_is_accepted" {
  command = plan

  variables {
    suffix = "qa01"
  }
}

# Empty suffix -> module generates a random 4-char suffix. Also fine.
run "empty_suffix_is_accepted" {
  command = plan

  variables {
    suffix = ""
  }
}

# Below the floor: caught by var.suffix's own validation block.
run "suffix_below_floor_is_rejected" {
  command = plan

  variables {
    suffix = "spo"
  }

  expect_failures = [
    var.suffix,
  ]
}

# Over the combined-length limit: caught by the precondition on the orchestrate
# service account. A 5-char suffix overflows "...-orchestrate-..." (31 chars) but
# still fits the shorter "...-scanner-..." / "...-sa-..." names, so this is the
# only resource that fails.
run "long_suffix_is_rejected_by_precondition" {
  command = plan

  variables {
    suffix = "abcde"
  }

  expect_failures = [
    google_service_account.agentless_orchestrate,
  ]
}

# A custom prefix of 14-17 chars passes var.suffix's validation and the other
# resource names, but still blows the orchestrate service account past 30.
run "long_prefix_plus_suffix_is_rejected_by_precondition" {
  command = plan

  variables {
    prefix = "lacework-awls-xx"
    suffix = "qa01"
  }

  expect_failures = [
    google_service_account.agentless_orchestrate,
  ]
}
