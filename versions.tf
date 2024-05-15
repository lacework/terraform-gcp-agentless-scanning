terraform {
  required_version = ">= 1.5"

  required_providers {
    google = ">= 4.46"
    lacework = {
      source  = "lacework/lacework"
      version = "~> 1.18"
    }
  }
}
