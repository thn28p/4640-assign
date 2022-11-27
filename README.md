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

 4.1 Paste the copied string into the box on mongoDB compass
  <img width="1050" alt="Screen Shot 2022-11-27 at 11 19 40 AM" src="https://user-images.githubusercontent.com/78245863/204117726-789d3397-a32d-4639-a7bc-db660b7ed400.png">

 4.2 After click connect, it will connect the database
<img width="670" alt="image" src="https://user-images.githubusercontent.com/78245863/204117521-c86b2dac-f4a0-4190-8097-5833254ce348.png">


#Bastion 
5. Another new component is bastion 
This the content of bastion


example:
    
    # Create a bastion server
    resource "digitalocean_droplet" "bastion_dp" {
    image    = var.rocky
    size     = var.rsize
    name     = "bastion-${var.region}"
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
    
<img width="890" alt="image" src="https://user-images.githubusercontent.com/78245863/204117902-0c475d88-8057-4c1c-9414-355e045006f1.png">

6. After created bastion may try to connect to the server via bastion
 first we need to run the commands to do ssh forwarding and the ssh agent
 
  01 command:
    
    eval $(ssh-agent)

<img width="1301" alt="image" src="https://user-images.githubusercontent.com/78245863/204118143-1fcc2f51-e0af-4be4-b96e-0fe1389b4a2e.png">


 02 command:
    
    ssh-add /home/vagrant/.ssh/id_rsa
    
 <img width="1413" alt="image" src="https://user-images.githubusercontent.com/78245863/204118161-cc3163fe-03ee-4667-9d39-81200200ef18.png">

now ssh into bastion vm
 03 command:
    
    ssh -A root@<replaceThiswithBastionPublicIP>
    
  <img width="874" alt="image" src="https://user-images.githubusercontent.com/78245863/204118231-955a35ac-3a50-4efb-b117-309058086675.png">

 now ssh into the server via bastion
 04 command:
    
    ssh root@<replaceThiswithServerPrivateIP>

<img width="874" alt="image" src="https://user-images.githubusercontent.com/78245863/204118301-cfc0d8f5-b537-41fd-a69d-5b789906204f.png">



 
    
 
    
    
    
