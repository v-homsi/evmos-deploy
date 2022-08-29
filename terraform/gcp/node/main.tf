
provider "google" {
  project = var.project
}

provider "google-beta" {
  project = var.project
}

data "google_client_config" "provider" {}

resource "google_project_service" "services" {
  for_each = {
    "clouderrorreporting.googleapis.com"  = true
    "cloudresourcemanager.googleapis.com" = true
    "compute.googleapis.com"              = true
    "container.googleapis.com"            = true
    "iam.googleapis.com"                  = true
    "logging.googleapis.com"              = true
    "monitoring.googleapis.com"           = true
  }
  service            = each.key
  disable_on_destroy = false
}
