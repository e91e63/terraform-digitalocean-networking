variable "acme" {
  type = object({
    email = string
  })
}

variable "domain_name" {
  type = string
}

variable "project_name" {
  type = string
}

variable "kube_config" {
  type = object({
    cluster_ca_certificate = string,
    host                   = string,
    token                  = string,
  })
}
