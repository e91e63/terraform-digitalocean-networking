data "digitalocean_project" "main" {
  name = var.project_conf.name
}

resource "digitalocean_domain" "main" {
  name = var.project_conf.domain_name
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
  project = data.digitalocean_project.main.id
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
      issuerRef = {
        name = "digitalocean"
        kind = "ClusterIssuer"
      }
      secretName = "${digitalocean_record.root.fqdn}-cert"
    }
  }
}

locals {
  do_pat_key  = "personal-access-token"
  do_pat_name = "digitalocean-pat"
}

resource "kubernetes_secret" "digitalocean_pat" {
  metadata {
    name = local.do_pat_name
  }

  data = {
    (local.do_pat_key) = var.cert_issuer_conf.personal_access_token
  }
}

resource "kubernetes_manifest" "cert_manager_issuer_digitalocean" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = "digitalocean"
    }
    spec = {
      acme = {
        email  = var.cert_issuer_conf.email
        server = "https://acme-v02.api.letsencrypt.org/directory"
        privateKeySecretRef = {
          name = "acme-account-key"
        }
        solvers = [
          {
            dns01 = {
              digitalocean = {
                tokenSecretRef = {
                  key  = local.do_pat_key
                  name = local.do_pat_name
                }
              }
            }
          }
        ]
      }
    }
  }
}
