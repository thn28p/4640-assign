# network.tf
#add new project
data "digitalocean_project" "lab_project" {
name = var.project
}

#Create a new tag
resource "digitalocean_tag" "do_tag" {
name = var.tag
}


#Create a new VPC
resource "digitalocean_vpc" "web_vpc" {
 name     = var.vpc
 region   = var.region
}
