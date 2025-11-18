terraform {
  required_version = ">= 1.5"

  required_providers {
    google = ">= 6.0"
    lacework = {
      source  = "lacework/lacework"
      version = "~> 2.0"
    }
  }
}
