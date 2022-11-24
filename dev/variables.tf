#variable.tf

#terraform variables
#
# The API token
variable "do_token" {}

#set the default region to sfo3
variable "region" {
 type = string
default = "sfo3"
}

#set the default droplet count
variable "droplet_count" {
 type = number
 default = 2 
}

#set the vpc name 
variable "vpc" {
    type = string
    default = "assignment-twu-vpc"
}

#set vm ubuntu info
variable "ubuntu" {
    type = string
    default = "ubuntu-22-04-x64"
}

#set vm size 1 gigabyte
variable "1g" {
    type = string
    default = "s-1vcpu-1gb"
}

#set vm rocky
variable "rocky" {
    type = string
    default = "rockylinux-9-x64"
}

#set vm size 512 megabyte
variable "five" {
    type = string
    default = "s-1vcpu-512mb-10gb"
}

#set tag name
variable "tab" {
    type = string
    default = "tag7assign01"
}