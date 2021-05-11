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