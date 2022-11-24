output "server_ip" {
  value = digitalocean_droplet.tag7assign01.*.ipv4_address
 }

output "vpc_id" {
  description = "ID of project VPC"
  value       = digitalocean_vpc.web_vpc.id
}

output "lb_url" {
  description = "URL of load balancer"
  value       = "loadbalancer-assign01"
}

output "web_server_count" {
  description = "Number of web servers provisioned"
  value       = var.droplet_count
}


