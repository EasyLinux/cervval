# Machine CERVVAL

## Introduction

Ce projet contient tout ce qui est nécessaire pour installer une machine de base à partir d'une image CentOS 8 sur architecture **Power9**

## Image

L'image choisie est une image `CentOS Linux release 8.3`

# Terraform

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

