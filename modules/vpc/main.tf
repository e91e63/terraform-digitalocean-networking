resource "digitalocean_vpc" "main" {
  description = "${var.project_info.name} VPC"
  ip_range    = var.vpc_conf.ip_range
  name        = "${var.project_info.name}-vpc"
  region      = var.vpc_conf.region
}

terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2"
    }
  }
  required_version = "~> 1"
}
