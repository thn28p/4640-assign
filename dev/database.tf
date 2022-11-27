#database.tf
#add database
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

resource "digitalocean_database_firewall" "example-fw" {
  cluster_id = digitalocean_database_cluster.cluster-mongo.id
  
  count = var.droplet_count

  rule {
    type  = "droplet"
    value = digitalocean_droplet.web[count.index].id
  }
}
