variable "project_info" {
  type = object({
    name = string
  })
}

variable "vpc_conf" {
  type = object({
    ip_range = string
    region   = string
  })
}
