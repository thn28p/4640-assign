#add database
resource "digitalocean_database_firewall" "example-fw" {
  cluster_id = digitalocean_database_cluster.cluster-mongo.id

  rule {
    type  = "tag"
    value = var.tag
  }
}

#create droplet that connects to db 
resource "digitalocean_droplet" "db_droplet" {
  image  = var.ubuntu
  size   = var.usize 
  count  = var.droplet_count
  name   = "web-${count.index + 1}"
  #add 25 520
  tags   = [digitalocean_tag.do_tag.id]
  region = var.region
}

resource "digitalocean_database_cluster" "cluster-mongo" {
  size       = "db-s-1vcpu-1gb"
  name       = "assign-mongo-cluster"
  engine     = "mongodb"
  version    = "4"
  #add 25 520
  tags   = [digitalocean_tag.do_tag.id]
  region     = var.region
  node_count = 1

  private_network_uuid = digitalocean_vpc.web_vpc.id
}
