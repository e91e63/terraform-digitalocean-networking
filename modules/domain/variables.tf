variable "cert_issuer_info" {
  type = object({
    ref = object({
      name = string
      kind = string
    })
  })
}

domain_conf = {
  type = object({
    name = string
  })
}

variable "load_balancer_info" {
  type = object({
    ip = string
  })
}

variable "project_info" {
  type = object({
    name = string
  })
}
