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
