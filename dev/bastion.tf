# Create a bastion server
resource "digitalocean_droplet" "bastion_dp" {
  image    = var.rocky
  size     = var.rsize
  name     = "bastion-${var.region}"
  #add 25 520
  tags   = [digitalocean_tag.do_tag.id]
  region   = var.region
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.id]
  vpc_uuid = digitalocean_vpc.web_vpc.id
}

# firewall for bastion server
resource "digitalocean_firewall" "bastion_firewall" {
  
  #firewall name
  name = "ssh-bastion-firewall"

  # Droplets to apply the firewall to
  droplet_ids = [digitalocean_droplet.bastion_dp.id]

  inbound_rule {
    protocol = "tcp"
    port_range = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol = "tcp"
    port_range = "22"
    destination_addresses = [digitalocean_vpc.web_vpc.ip_range]
  }

  outbound_rule {
    protocol = "icmp"
    destination_addresses = [digitalocean_vpc.web_vpc.ip_range]
  }
}

