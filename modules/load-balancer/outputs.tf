output "info" {
  value = {
    http_target_port  = var.load_balancer_conf.http_target_port
    https_target_port = var.load_balancer_conf.https_target_port
    ip                = digitalocean_loadbalancer.main.ip
  }
}
