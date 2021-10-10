output "info" {
  value = {
    id     = digitalocean_vpc.main.id
    region = digitalocean_vpc.main.region
  }
}
