#add database
resource "digitalocean_database_firewall" "example-fw" {
  cluster_id = digitalocean_database_cluster.mongodb-example.id

  rule {
    type  = "tag"
    value = "tag7assign01"
  }
}

resource "digitalocean_droplet" "db_vm" {
  image  = var.ubuntu
  count  = var.droplet_count
  name   = "web-server-assign-${count.index + 1}"
  tags     = [digitalocean_tag.do_tag.id]
  region = var.region
  size   = var.one
}

resource "digitalocean_database_cluster" "mongodb-example" {
  name       = "4640-twu-asssign-cluster"
  engine     = "mongodb"
  version    = "4" 
  size       = "db-s-1vcpu-1gb"
  region     = var.region
  node_count = 1 

  private_network_uuid = digitalocean_vpc.web_vpc.id
}

