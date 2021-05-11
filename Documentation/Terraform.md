# Terraform

Mise en oeuvre de terraform 

Terraform est un logiciel de déploiement d'architecteure as code (iaac). [Terraform](https://www.terraform.io/) 

Losrque vous lancez terraform, il analyse les fichiers présents dans l'arborescence aver pour extension .tf
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

