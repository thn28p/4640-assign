terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    } 
  }
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "ssh_key"{
  name = var.ssh_key
}

data "digitalocean_project" "lab_project" {
name = var.project
}

#Create a new tag
resource "digitalocean_tag" "do_tag" {
name = var.tag
}
