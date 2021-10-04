variable "lb_conf" {
  type = object({
  })
}

variable "project_conf" {
  type = object({
    domain_name = string
    name        = string
    region      = string
  })
}
