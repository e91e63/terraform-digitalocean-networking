output "info" {
  value = {
    ip = digitalocean_loadbalancer.main.ip
  }
}
