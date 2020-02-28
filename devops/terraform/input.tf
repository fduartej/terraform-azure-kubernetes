#variables from input.variables.tfvars
variable "project_prefix" {}
variable "project_locations" {}
variable "project_rg_name" {}

variable "credentials_client_email" {}
variable "credentials_subscription_id" {}
variable "credentials_client_id" {}
variable "credentials_client_secret" {}
variable "credentials_tenant_id" {}

variable "resource_admin_username" {}

#input setup common 
variable "config_common" {
    type   = map
    default = {
        "tag_environment_dev"        = "DEVELOPMENT"
        "tag_environment_prd"        = "PRODUCTION"
    }    
}

variable "config_tagging_conventions" {
  type        = map
  default     = {
    storage      = "sa"
    kubernetes   = "aks"
    api_mgt      = "api"
    registry     = "acr"
    vnet         = "vnet"
    sub_net      = "snet"  
    log_ws       = "lws"  
  }  
}

#input setup vnets [existing or new]
#http://jodies.de/ipcalc?host=10.1.0.0&mask1=16&mask2=24
#172.16.110.0/16 - 172.16.110.0/24 prd
#172.15.111.0/16 - 172.15.111.0/24 dev
variable "vnet_prd" {
    type    = map
    default = {
        "name"        = "prd01"
        "description" = "Red de Ambiente de Producción"  
        "iprange"     = "172.16.0.0/16"     
    }    
}

variable "subnet_prd" {
    type    = map
    default = {    
        "name"        = "prd01-use1"
        "description" = "Subnet de Producción"
        "iprange"     = "172.16.0.0/24"
        "delegation"  = "vnetprddelegation"
    }
}

variable "vnet_dev" {
    type   = map
    default = {
        "name"        = "dev01"
        "description" = "Red de Ambiente de Desarrollo"
        "iprange"     = "172.15.0.0/16"
    }    
}

variable "subnet_dev" {
    type    = map
    default = {    
        "name"        = "dev01-use1"
        "description" = "Subnet de Desarrollo"
        "iprange"     = "172.15.0.0/24"
        "delegation"  = "vnetdevdelegation"
    }
}

#input setup storage
variable "storage_dev" {
    type = map
    default = {
        "name"              = "dev01use1"
        "tier"              = "Standard"
        "replication_type"  = "GRS"
    }  
}

variable "storage_prd" {
    type = map
    default = {
        "name"              = "prd01use1"
        "tier"              = "Standard"
        "replication_type"  = "GRS"
    }  
}

#input setup registry
variable "registry_common" {
    type = map
    default = {
        "name" = "inteprd1"
        "sku"  = "Standard"
        "admin_enabled" = true
    }  
}

#input setup aks
#DEV
variable "aks_prd" {
    type = map
    default = {
        name                               = "prd01use1"
        dns_prefix                         = "aksprd01use1"
        oms_agent_enable                   = true
        http_application_routing_enable    = true
        kube_dashboard_enable              = true
    }
}

variable "aks_node_pool_prd" {
    type = map
    default = {
        "name"         = "npoolprd"
        "nodecount"    = 1
        "max_pods"     = 100
        "disktype"     = "Standard_DS1_v2"
        "disksize"     = 50
    }
} 

#PRD

#input setup aks monitoring
variable "log_ws" {
    type = map
    default = {
        name             = "prd01use1"
        sku              = "PerGB2018"
        retention_in_days  = 30
    }
} 

variable "log_insights" {
    type = map
    default = {
        solution_name    = "ContainerInsights"
        plan_publisher   = "Microsoft"
        plan_product     = "OMSGallery/Containers"
    }
} 

variable "log_security" {
    type = map
    default = {
        solution_name    = "Security"
        plan_publisher   = "Microsoft"
        plan_product     = "OMSGallery/Security"
    }
} 
#input setup api management
variable "api_mgt_prd" {
    type = map
    default = {
        "name"         = "prd01use1"
        "company"      = "inteligo"
        "sku_name"     = "Basic_1"
    }
} 

#ssh key
variable "public_ssh_key" {
  description = "A custom ssh key to control access to the AKS cluster"
  default     = ""
}
