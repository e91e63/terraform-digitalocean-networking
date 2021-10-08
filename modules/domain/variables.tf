variable "cert_issuer_conf" {
  type = object({
    email                 = string
    personal_access_token = string
  })
}

variable "k8s_info" {
  type = object({
    cluster_ca_certificate = string,
    host                   = string,
    token                  = string,
  })
}

variable "load_balancer_info" {
  type = object({
    ip = string
  })
}

variable "project_conf" {
  type = object({
    domain_name = string
    name        = string
  })
}
