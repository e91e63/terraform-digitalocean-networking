resource "digitalocean_record" "main" {
  domain = var.subdomain_conf.domain_name
  type   = "CNAME"
  name   = var.subdomain_conf.name
  value  = "${var.subdomain_conf.domain_name}."
}

resource "kubernetes_manifest" "ambassador_host" {
  manifest = {
    "apiVersion" = "getambassador.io/v2"
    "kind"       = "Host"
    "metadata" = {
      "name"      = digitalocean_record.main.fqdn
      "namespace" = "default"
    }
    "spec" = {
      "acmeProvider" = {
        "email" = var.subdomain_conf.email
      }
      "hostname" = digitalocean_record.main.fqdn
    }
  }
}

# resource "kubernetes_manifest" "ambassador_mapping" {
#   manifest = {
#     apiVersion = "getambassador.io/v2"
#     kind       = "Mapping"
#     metadata = {
#       name      = digitalocean_record.main.fqdn
#       namespace = "default"
#     }
#     spec = {
#       host    = digitalocean_record.main.fqdn
#       prefix  = "/"
#       service = var.subdomain_conf.name
#     }
#   }
# }
