/*
    DESCRIPTION:
    Ubuntu Server 20.04 LTS template using the Packer Builder for VMware vSphere (vsphere-iso).
*/

//  BLOCK: packer
//  The Packer configuration.

packer {
  required_version = ">= 1.8.2"
  required_plugins {
    googlecompute = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/googlecompute"
    }
  }
}

//  BLOCK: source
//  Defines the builder configuration blocks.

source "googlecompute" "gcp_image" {
  project_id = var.project_id
  source_image = "ubuntu-2004-focal-v20220810"
  ssh_username = "packer"
  zone = var.zone
  image_name = "${var.image_name_prefix}-{{timestamp}}"
  image_family = var.image_family
}

build {
  sources = ["sources.googlecompute.gcp_image"]
  
  provisioner "ansible" {
    user = "packer"
    playbook_file = "${path.cwd}/ansible/evmos_testnet.yml"
    roles_path    = "${path.cwd}/ansible/roles"
    ansible_env_vars = [
      "ANSIBLE_CONFIG=${path.cwd}/ansible/ansible.cfg"
    ]
  }
}
