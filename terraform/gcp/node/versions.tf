
terraform {
  required_version = "~> 1.2.0"
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    google-beta = {
      source = "hashicorp/google-beta"
    }
    local = {
      source = "hashicorp/local"
    }
    time = {
      source = "hashicorp/time"
    }
  }
  backend "gcs" {
    bucket = "" # bucket name created in step 2
    prefix = "state/fullnode"
  }
}
