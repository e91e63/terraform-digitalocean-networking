terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2"
    }
  }
  required_version = "~> 1"
}

resource "digitalocean_domain" "main" {
  name = var.domain_conf.name
}

resource "digitalocean_record" "root" {
  domain = digitalocean_domain.main.name
  name   = "@"
  ttl    = 30
  type   = "A"
  value  = var.load_balancer_info.ip
}

resource "digitalocean_record" "star" {
  domain = digitalocean_domain.main.name
  name   = "*"
  ttl    = 30
  type   = "CNAME"
  value  = "${digitalocean_domain.main.name}."
}

resource "digitalocean_project_resources" "main" {
  project = var.project_info.id
  resources = [
    digitalocean_domain.main.urn
  ]
}

resource "kubernetes_manifest" "cert_manager_certificate" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "Certificate"
    metadata = {
      name      = digitalocean_record.root.fqdn
      namespace = "default"
    }
    spec = {
      dnsNames = [
        digitalocean_record.root.fqdn,
        digitalocean_record.star.fqdn,
      ]
      issuerRef  = var.cert_issuer_info.ref
      secretName = "${digitalocean_record.root.fqdn}-cert"
    }
  }
}
