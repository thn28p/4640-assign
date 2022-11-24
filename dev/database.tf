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
  #added to project 4640
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.id]
  vpc_uuid = digitalocean_vpc.web_vpc.id
  lifecycle {
   create_before_destroy = true
  }

  private_network_uuid = digitalocean_vpc.web_vpc.id
}

#add attach database to 4640-project
resource "digitalocean_project_resources" "project_attach" {
  project = data.digitalocean_project.lab_project.id
  resources = flatten([ digitalocean_droplet.db_vm.*.urn])
}
