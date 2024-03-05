terraform {
  cloud {
    organization = "personal_geniushee"

    workspaces {
      name = "ws-8arm"
    }
  }

  required_providers {
    ncloud = {
      source = "NaverCloudPlatform/ncloud"
    }
  }
  required_version = ">= 0.13"
}

// Configure the ncloud provider
provider "ncloud" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

resource "ncloud_public_ip" "public_ip" {
  server_instance_no = module.module_server.server_id
}

module "module_server" {
  source = "./sever_module"
}

