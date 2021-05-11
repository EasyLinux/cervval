resource "openstack_blockstorage_volume_v2" "vol" {
  name = var.vol_name
  size = var.vol_size
}

resource "openstack_compute_instance_v2" "vm" {
  name      = var.vm_name
  image_id  = var.vm.image_id
  flavor_id = var.vm.instance_type
  network {
    name        = var.network_name
    fixed_ip_v4 = var.vm_ip
  }
  availability_zone = var.openstack_availability_zone
}

# Attacher le volume cree a la vm
resource "openstack_compute_volume_attach_v2" "attached" {
  instance_id = openstack_compute_instance_v2.vm.id
  volume_id   = openstack_blockstorage_volume_v2.vol.id
} 

# To check vm availability before running commands (provisioners) 
resource "null_resource" "check_vm" {
  # Connect to the vm as root in order to run the script with right privilege
  connection {
    type     = "ssh"
    host     = openstack_compute_instance_v2.vm.access_ip_v4
    user     = var.user_name
    password = var.user_password
    timeout  = "1h"
  }

  provisioner "remote-exec" {
    inline = [
      "whoami"
    ]
  }

}

