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

Avant de travailler avec terraform, il faut définir un provider. C'est un ou plusieurs plugin. Dans notre cas (Powervc), nous allons utiliser `Openstack` c'est le système utilisé par Powervc

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
