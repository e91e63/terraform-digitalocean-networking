
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
