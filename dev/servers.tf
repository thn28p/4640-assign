#add balancer
resource "digitalocean_loadbalancer" "public" {
 name = "loadbalancer-assign01"
 region = var.region

forwarding_rule {
   entry_port = 80
   entry_protocol = "http"

   target_port = 80
   target_protocol = "http"
 }

 healthcheck {
  port      = 22
  protocol  = "tcp"
 }

 droplet_tag = var.tag 
 vpc_uuid = digitalocean_vpc.web_vpc.id
}

resource "digitalocean_firewall" "web_dp_firewall" {

    # The name we give our firewall for ease of use                                
    name = "web-firewall"

    # The droplets to apply this firewall to   
    droplet_ids = digitalocean_droplet.db_droplet.*.id

    # Internal VPC Rules. We have to let ourselves talk to each other
    inbound_rule {
        protocol = "tcp"
        port_range = "1-65535"
        source_addresses = [digitalocean_vpc.web_vpc.ip_range]
    }

    inbound_rule {
        protocol = "udp"
        port_range = "1-65535"
        source_addresses = [digitalocean_vpc.web_vpc.ip_range]
    }

    inbound_rule {
        protocol = "icmp"
        source_addresses = [digitalocean_vpc.web_vpc.ip_range]
    }

    outbound_rule {
        protocol = "udp"
        port_range = "1-65535"
        destination_addresses = [digitalocean_vpc.web_vpc.ip_range]
    }

    outbound_rule {
        protocol = "tcp"
        port_range = "1-65535"
        destination_addresses = [digitalocean_vpc.web_vpc.ip_range]
    }

    outbound_rule {
        protocol = "icmp"
        destination_addresses = [digitalocean_vpc.web_vpc.ip_range]
    }

    # Selective Outbound Traffic Rules

    # HTTP
    outbound_rule {
        protocol = "tcp"
        port_range = "80"
        destination_addresses = ["0.0.0.0/0", "::/0"]
    }

    # HTTPS
    outbound_rule {
        protocol = "tcp"
        port_range = "443"
        destination_addresses = ["0.0.0.0/0", "::/0"]
    }

    # ICMP (Ping)
    outbound_rule {
        protocol              = "icmp"
        destination_addresses = ["0.0.0.0/0", "::/0"]
    }
}
