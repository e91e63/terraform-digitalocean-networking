terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.11.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.5.0"
    }
  }

  required_version = "~> 1"
}

provider "kubernetes" {
  cluster_ca_certificate = base64decode(var.kube_config.cluster_ca_certificate)
  host                   = var.kube_config.host
  token                  = var.kube_config.token

  experiments {
    manifest_resource = true
  }
}
