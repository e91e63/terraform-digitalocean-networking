data "digitalocean_loadbalancer" "main" {
  name = "${var.project_conf.name}-k8s-load-balancer"
}

data "digitalocean_project" "main" {
  name = var.project_conf.name
}

resource "digitalocean_domain" "main" {
  name       = var.project_conf.domain_name
  ip_address = data.digitalocean_loadbalancer.main.ip
}

resource "digitalocean_project_resources" "main" {
  project = data.digitalocean_project.main.id
  resources = [
    digitalocean_domain.main.urn
  ]
}

resource "kubernetes_manifest" "ambassador_host" {
  manifest = {
    "apiVersion" = "getambassador.io/v2"
    "kind"       = "Host"
    "metadata" = {
      "name"      = "${var.project_conf.domain_name}"
      "namespace" = "default"
    }
    "spec" = {
      "acmeProvider" = {
        "email" = var.acme_conf.email
      }
      "hostname" = var.project_conf.domain_name
    }
  }
}
