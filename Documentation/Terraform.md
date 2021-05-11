# Terraform

Mise en oeuvre de terraform 

Terraform est un logiciel de déploiement d'architecteure as code (iaac). [Terraform](https://www.terraform.io/) 

Losrque vous lancez terraform, il analyse les fichiers présents dans l'arborescence avec l'extension `.tf`  
Il est possible de positionner des variables via un fichier terraform.tfvars ou auto.var.tfvars

## Implémentation 

Organisation des fichiers

``` 
.
├── credentials.sample             # Exemple de credentials 
├── data                           # Fichiers à utiliser  
├── main.tf                        # Code principal 
├── modules                        # Module (fonction) 
│   └── 1_base                  
│       ├── base.tf                # Fonction 
│       ├── output.tf              # Sorties du module 
│       ├── scripts                # Scripts / fichiers 
│       │   ├── 10_network.cfg     # Configuration cloud-init 
│       │   └── install.sh         # Ajout disque dur 
│       └── variables.tf           # Variables du module 
├── provider.tf                    # Définition du provider (accès à OpenStack) 
├── terraform.tfstate              # Etat de la machine (généré par Terraform) 
├── terraform.tfstate.backup       # Sauvegarde (Etat n-1) 
├── terraform.tfvars               # Valeurs de variables
├── terraform.tfvars.sample        # Exemple de variables 
└── variables.tf                   # Définition des variables 
``` 

## provider.tf

Avant de travailler avec terraform, il faut définir un provider. C'est un ou plusieurs plugin. Dans notre cas (Powervc), nous allons utiliser `Openstack` c'est le système utilisé par Powervc.

Le fichier **provider.tf** :

```terraform
# Définir le provider à utiliser
# Nous utilisons le provider OpenStack qui est la base de l'outil PowerVC

provider "openstack" {
  version     = "~> 1.29.0"
  user_name   = var.os_name
  password    = var.os_password
  auth_url    = var.auth_url
  tenant_name = var.tenant_name
  domain_name = var.domain_name
  insecure    = var.insecure
}

provider "random" {
  version = "~> 2.3.0"
} 

```  
 > **NB**: les références var.<xxx> font référence à une variable (voir plus bas)

## variable.tf

Le fichier **variables.tf** définit les variables qui seront utilisées dans le déploiement

 > **NB**: Le contenu des variables est défini dans un fichier `terraform.tfvars` ce fichier est séparé de la définition 

 Fichier **variables.tf**

 ```terraform
 ################################################################
# Configure the OpenStack Provider                             #  
################################################################
variable "os_name" {
  description = "The user name used to connect to OpenStack"
  default     = ""
}
variable "os_password" {
  description = "The password for the user"
  default     = ""
}
variable "keypair_name" {
  # Set this variable to the name of an already generated
  # keypair to use it instead of creating a new one.
  default = ""
}
variable "public_key_file" {
  description = "Path to public key file"
  # if empty, will default to ${path.cwd}/data/id_rsa.pub
  default = ""
}
variable "private_key_file" {
  description = "Path to private key file"
  # if empty, will default to ${path.cwd}/data/id_rsa
  default = ""
}
variable "private_key" {
  description = "content of private ssh key"
  # if empty string will read contents of file at var.private_key_file
  default = ""
}
variable "public_key" {
  description = "Public key"
  # if empty string will read contents of file at var.public_key_file
  default = ""
}

variable "tenant_name" {
  description = "The name of the project (a.k.a. tenant) used"
  default     = ""
}

variable "domain_name" {
  description = "The domain to be used"
  default     = ""
}

variable "auth_url" {
  description = "The endpoint URL used to connect to OpenStack"
  default     = ""
}

variable "insecure" {
  default = "true"
  # OS_INSECURE
}

variable "openstack_availability_zone" {
  description = "The name of Availability Zone for deploy operation"
  default     = ""
}

################################################################
# Configure the Instance details
################################################################
variable "vm" {
  default = {
    instance_type = ""
    image_id      = ""
  }
}

variable "vm_name" {
  description = "Machine name"
  default     = ""
}

variable "vm_ip"{
  description = "Fixed ip address"
  default     = ""
} 

variable "user_name" {
  description = "User name (ssh)"
  default     = ""
}

variable "user_password" {
  description = "User name (ssh)"
  default     = ""
}

variable "network_name" {
  description = "The name of the network to be used for deploy operations"
  default     = ""
}

variable "network_type" {
  #Eg: SEA or SRIOV
  default     = "SEA"
  description = "Specify the name of the network adapter type to use for creating hosts"
}

variable "scg_id" {
  description = "The id of PowerVC Storage Connectivity Group to use for all nodes"
  default     = ""
}

variable "vm_id_prefix" {
  default = "lab"
}

# Openstack
# locals {
#   private_key_file = "${var.private_key_file == "" ? "${path.cwd}/data/id_rsa" : "${var.private_key_file}"}"
#   public_key_file  = "${var.public_key_file == "" ? "${path.cwd}/data/id_rsa.pub" : "${var.public_key_file}"}"
#   private_key      = "${var.private_key == "" ? file(coalesce(local.private_key_file, "/dev/null")) : "${var.private_key}"}"
#   public_key       = "${var.public_key == "" ? file(coalesce(local.public_key_file, "/dev/null")) : "${var.public_key}"}"
#   create_keypair   = "${var.keypair_name == "" ? "1" : "0"}"
# }

variable "repo_file" {
  default = ""
}

variable "vol_name" {
  description = "Volume's name "
  default     = ""
}

variable "vol_size" {
  description = "Volume's size in Mb"
  default     = 0
}
```
