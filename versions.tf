terraform {
  required_version = ">= 0.12.31"

  required_providers {
    google = "~> 4.0"
    lacework = {
      source  = "lacework/lacework"
      version = "~> 1.0"
    }
  }
}
