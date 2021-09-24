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
  cluster_ca_certificate = base64decode(var.k8s_conf.cluster_ca_certificate)
  host                   = var.k8s_conf.host
  token                  = var.k8s_conf.token

  experiments {
    manifest_resource = true
  }
}
