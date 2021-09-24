variable "acme_conf" {
  type = object({
    email = string
  })
}

variable "project_conf" {
  type = object({
    domain_name = string
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
