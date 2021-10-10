variable "load_balancer_conf" {
  type = object({
    droplet_tag       = string
    http_target_port  = string
    https_target_port = string
    region            = string
    vpc_id            = string
  })
}

variable "project_info" {
  type = object({
    id   = string
    name = string
  })
}
