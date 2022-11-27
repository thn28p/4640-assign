#Assigment README file
# Expand on terraform
1.This assigement will have a bastion to login to the servers
<img width="615" alt="Screen Shot 2022-11-27 at 10 40 24 AM" src="https://user-images.githubusercontent.com/78245863/204116843-a0643502-b2d1-44e5-b328-fd29c3ce1ea4.png">


2. Also will breake the long main.tf into an organized file structure
<img width="666" alt="image" src="https://user-images.githubusercontent.com/78245863/204116936-37a6061d-c038-40ea-bb2d-ee2c05274964.png">

3. New component database is created in this assignment
This is the content of the database.tf

example:
    
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
    
  
 <img width="666" alt="image" src="https://user-images.githubusercontent.com/78245863/204117198-cbdcb402-97d3-40e0-bc15-742a237d7ad3.png">

4. To connect the database we need to copy the string from DO

<img width="561" alt="image" src="https://user-images.githubusercontent.com/78245863/204117229-988fe7ae-6e6b-4bf6-9c2e-ca9f7b1f8837.png">

Paste the copied string into the box on mongoDB compass
<img width="1046" alt="Screen Shot 2022-11-27 at 11 00 33 AM" src="https://user-images.githubusercontent.com/78245863/204117301-18e2e018-7a4a-4f86-aedb-0c3541b0242f.png">

example:
    
    su 

    
