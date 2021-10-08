variable "cert_issuer_conf" {
  default = {}
  type    = optional(any)
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
