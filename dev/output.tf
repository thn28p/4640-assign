output "server_ip" {
  description = "server ip address:"  
  value = digitalocean_droplet.web.*.ipv4_address
 }

# output "vpc_id" {  
#   description = "ID of project VPC:"  
#   value     = digitalocean_vpc.web_vpc.id
#   }

# output "lb_url" {
#     description = "URL of load balancer:"
#     value     = "loadbalancer-assign01"
#   }
      
# output "web_server_count" {
#     description = "Number of web servers provisioned"
#     value       = ${count.index}#var.droplet_count
#   }
