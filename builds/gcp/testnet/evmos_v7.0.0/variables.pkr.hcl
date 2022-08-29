/*
    DESCRIPTION:
    Evmos Ubuntu Server 20.04 LTS variables using the Packer Builder.
*/


variable "project_id" {
  type = string
  description = "The google project id to create image in"
}

variable "zone" {
  type = string
  description = "The GCP zone to create image in"
}

variable "image_name_prefix" {
  type = string
  description = "The output image name prefix to create"
}

variable "image_family" {
  type = string
  description = "The output image family to create"
}

