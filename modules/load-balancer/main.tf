data "digitalocean_project" "main" {
  name = var.project_conf.name
}

data "digitalocean_vpc" "main" {
  name = "${var.project_conf.name}-k8s-cluster"
}

resource "digitalocean_loadbalancer" "main" {
  droplet_tag = "${var.project_conf.name}-k8s-worker"
  name        = "${var.project_conf.name}-load-balancer"
  region      = var.project_conf.region
  vpc_uuid    = data.digitalocean_vpc.main.id

  # TODO: pull these from nodeport config
  forwarding_rule {
    entry_port      = 80
    entry_protocol  = "http"
    target_port     = 32080
    target_protocol = "http"
  }

  forwarding_rule {
    entry_port      = 443
    entry_protocol  = "https"
    target_port     = 32443
    target_protocol = "https"
    tls_passthrough = true
  }

  healthcheck {
    port     = 22
    protocol = "tcp"
  }
}

resource "digitalocean_project_resources" "main" {
  project = data.digitalocean_project.main.id
  resources = [
    digitalocean_loadbalancer.main.urn
  ]
}
