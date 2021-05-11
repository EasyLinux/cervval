# output "vm_id" {
#   value = openstack_compute_instance_v2.vm.vm_id
# }

output "vm_ip" {
  value = openstack_compute_instance_v2.vm.access_ip_v4
}

output "vm_dump"{
     value = openstack_compute_instance_v2.vm
} 