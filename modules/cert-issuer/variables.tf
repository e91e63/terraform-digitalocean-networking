variable "cert_issuer_conf" {
  type = object({
    email                 = string
    personal_access_token = string
  })
}
