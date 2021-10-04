# TODO: Get from loadbalancer
data "digitalocean_loadbalancer" "main" {
  name = "${var.project_conf.name}-load-balancer"
}

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
  value  = data.digitalocean_loadbalancer.main.ip
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
