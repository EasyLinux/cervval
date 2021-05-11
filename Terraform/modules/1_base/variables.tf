variable "vm_id" {
  default = ""
}
variable "vm" {
  default = {
    instance_type = ""
    image_id      = ""
    name          = ""
  }
}

# Disk
variable "vol_name"{}
variable "vol_size"{}

variable "vm_name"{} 
variable "vm_ip"{} 
variable "user_name"{} 
variable "user_password"{} 
# variable "repo_file"{} 
variable "network_name" {}
variable "scg_id" {}
variable "openstack_availability_zone" {}
variable "vm_username" {}
variable "vm_userpassword" {}

#openstack connexion
# variable "private_key" {}
# variable "public_key" {}
# variable "create_keypair" {}
# variable "keypair_name" {}