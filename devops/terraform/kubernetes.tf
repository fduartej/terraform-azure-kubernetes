#Kubernetes
module "ssh-key" {
  source         = "./modules/ssh-key"
  public_ssh_key = var.public_ssh_key == "" ? "" : var.public_ssh_key
}

#PRD
resource "azurerm_kubernetes_cluster" "aks_prd" {
  name                = "${var.config_tagging_conventions["kubernetes"]}-${var.aks_prd["name"]}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.aks_prd["dns_prefix"]

  addon_profile {
    oms_agent {
      enabled                    = var.aks_prd["oms_agent_enable"]
      log_analytics_workspace_id = azurerm_log_analytics_workspace.log_ws.id
    }
    http_application_routing {
      enabled = var.aks_prd["http_application_routing_enable"]
    }
    kube_dashboard {
      enabled = var.aks_prd["kube_dashboard_enable"]
    }
  }

  linux_profile {
    admin_username = var.resource_admin_username

    ssh_key {
      # remove any new lines using the replace interpolation function
      key_data = replace(var.public_ssh_key == "" ? module.ssh-key.public_ssh_key : var.public_ssh_key, "\n", "")
    }
  }

  default_node_pool  {
    name            = var.aks_node_pool_prd["name"]
    node_count      = var.aks_node_pool_prd["nodecount"]
    vm_size         = var.aks_node_pool_prd["disktype"]
    os_disk_size_gb = var.aks_node_pool_prd["disksize"]
    max_pods        = var.aks_node_pool_prd["max_pods"]
    //vnet_subnet_id  = azurerm_subnet.subnet_prd.id
  }

  service_principal {
    client_id     = var.credentials_client_id
    client_secret = var.credentials_client_secret
  }

  tags = {
    environment = var.config_common["tag_environment_prd"]
    project = var.project_prefix
  }
}

output "aks_prd_client_certificate" {
  value = azurerm_kubernetes_cluster.aks_prd.kube_config.0.client_certificate
}

output "aks_prd_kube_config" {
  value = azurerm_kubernetes_cluster.aks_prd.kube_config_raw
}
