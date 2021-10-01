variable "subdomain_conf" {
  type = object({
    domain_name = string
    email       = string
    name        = string
  })
}

variable "k8s_conf" {
  type = object({
    cluster_ca_certificate = string,
    host                   = string,
    token                  = string,
  })
}
