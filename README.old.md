# Machine CERVVAL

## Introduction

Ce projet contient tout ce qui est nécessaire pour installer une machine de base à partir d'une image CentOS 8 sur architecture **Power**

## Image

L'image choisie est une image `CentOS Linux release 8.3`

# Terraform

[Documentation](Documentation/Terraform.md)


Commencer par copier le fichier `credentials.sample` en `.credentials`, puis `terraform.tfvars.sample` en `terraform.tfvars`      

* Le fichier `.credentials` contient le compte et mot de passe pour l'accès à **PowerVC**
* Editer les valeurs de `terraform.tfvars`
* Créer des clés ssh dans data `ssh-keygen` (si nécessaire)

Prendre en compte le compte / mot de passe :
```bash
source .credentials
```  

Lancer la construction de la VM via `terraform plan` puis 
```bash 
terraform init
terraform plan
terraform apply
``` 

## Variables

* **auth_url** URL pour l'accès à PowerVC
* **tenant_name** Nom du projet Powevc

> **NB**: pour des raisons de sécurité, les credentials sont passés en variables d'environnement
```bash
# export TF_VAR_os_name=
# export TF_VAR_os_password=
```

* **openstack_availability_zone** Groupe d'hôtes
* **scg_id** Identifiant du stockage
* **network_name** Nom du vlan 
* **network_type** Type de réseau (SEA)

Accès à la vm
* **user_name** Compte à utiliser (ssh)
* **user_password** mot de passe associé

* **instance_type** Identifiant du type d'instance
* **image_id** Identifiant de l'image à utiliser
* **vm_name** Nom de la machine (hostname)
* **vm_ip** Adresse ip

* **vol_name** Nom du volume 
* **vol_size** Taille du volume en méga (ex: 1500)

## Actions manuelles

> **NB**: actuellement la machine n'est pas visible depuis le réseau où se trouve terraform, il faut réaliser des étapes manuelles pour finaliser l'installation

### Ajout du disque 

Lancer les commandes suivantes

```bash 
pvcreate /dev/mapper/mpathc
vgcreate vg_data /dev/mapper/mpathc
lvcreate -l 100%FREE -n lv_data vg_data
mkfs.xfs /dev/mapper/vg_data-lv_data
mkdir /lv_data
echo "/dev/mapper/vg_data-lv_data     /data           xfs     defaults        0 0" >> /etc/fstab
systemctl daemon-reload
mount -a
```

### Prise en compte de l'IP

Cloud-init présente un **bug** en CentOS 8, l'adresse ip est ré-initialisée au reboot, pour l'éviter, créer le fichier 10_network.cfg suivant :

```yaml
# dans /etc/cloud/cloud.cfg.d

network:
  version: 2
  ethernets:
    env32:
      dhcp4: false
      dhcp6: false
      addresses: [172.25.153.209/28]
      gateway4: 172.25.153.214
      nameservers:
        addresses: [8.8.8.8]
```  