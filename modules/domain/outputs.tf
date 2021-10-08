output "info" {
  value = {
    name            = digitalocean_domain.main.name
    tls_secret_name = kubernetes_manifest.cert_manager_certificate.object.spec.secretName
  }
}
