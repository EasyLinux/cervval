# Choix de la version de Terraform
terraform {
  required_version = ">= 0.12.0, < 0.13.0"
  required_providers {
    openstack = {
      version = "1.29.0"
    }
    random = {
      version = "2.3.0"
    }
  }
}

# Création de la machine
module "vm" {
  source                      = "./modules/1_base"
  vm                          = var.vm
  vm_name                     = var.vm_name
  vm_ip                       = var.vm_ip
  user_name                   = var.user_name
  user_password               = var.user_password
  network_name                = var.network_name
  scg_id                      = var.scg_id
  openstack_availability_zone = var.openstack_availability_zone
  vm_username                 = var.user_name
  vm_userpassword             = var.user_password
  # private_key                 = local.private_key
  # public_key                  = local.public_key
  # create_keypair              = local.create_keypair
  # repo_file                   = var.repo_file
  # keypair_name                = ""
  vol_name                    = var.vol_name
  vol_size                    = var.vol_size
}