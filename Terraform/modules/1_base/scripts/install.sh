#!/bin/bash

# Ajout du disque 
pvcreate /dev/mapper/mpathc
vgcreate vg_data /dev/mapper/mpathc
lvcreate -l 100%FREE -n lv_data vg_data
mkfs.xfs /dev/mapper/vg_data-lv_data
mkdir /lv_data
echo "/dev/mapper/vg_data-lv_data     /data           xfs     defaults        0 0" >> /etc/fstab
systemctl daemon-reload
mount -a
