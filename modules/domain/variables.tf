variable "cert_issuer_info" {
  type = object({
    ref = object({
      name = string
      kind = string
    })
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
