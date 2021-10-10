resource "digitalocean_loadbalancer" "main" {
  droplet_tag = var.load_balancer_conf.droplet_tag
  name        = "${var.project_info.name}-load-balancer"
  region      = var.load_balancer_conf.region
  vpc_uuid    = var.load_balancer_conf.vpc_id

  forwarding_rule {
    entry_port      = 80
    entry_protocol  = "http"
    target_port     = var.load_balancer_conf.http_target_port
    target_protocol = "http"
  }

  forwarding_rule {
    entry_port      = 443
    entry_protocol  = "https"
    target_port     = var.load_balancer_conf.https_target_port
    target_protocol = "https"
    tls_passthrough = true
  }

  healthcheck {
    port     = 22
    protocol = "tcp"
  }
}

resource "digitalocean_project_resources" "main" {
  project = var.project_info.id
  resources = [
    digitalocean_loadbalancer.main.urn
  ]
}
