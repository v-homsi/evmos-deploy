variable "project" {
  description = "GCP project"
  type        = string
}

variable "machine_type" {
  description = "Machine type for running fullnode"
  default     = "e2-standard-8"
}

variable "network_prefix" {
  type    = string
  default = "evmos"
}

variable "region" {
  type    = string
  default = "us-central1"
}
