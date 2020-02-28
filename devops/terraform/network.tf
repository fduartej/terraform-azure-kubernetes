# Create a virtual networks
#DEV
resource "azurerm_virtual_network" "vnet_dev" {
  name                = "${var.config_tagging_conventions["vnet"]}-${var.vnet_dev["name"]}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = [var.vnet_dev["iprange"]]

  tags = {
    environment = var.config_common["tag_environment_dev"]
    project = var.project_prefix
  }
}

resource "azurerm_subnet" "subnet_dev" {
  name                 = "${var.config_tagging_conventions["sub_net"]}-${var.subnet_dev["name"]}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet_dev.name
  address_prefix       = var.subnet_dev["iprange"]

  delegation {
    name = var.subnet_dev["delegation"]

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
  }
  
}
#PROD
resource "azurerm_virtual_network" "vnet_prd" {
  name                = "${var.config_tagging_conventions["vnet"]}-${var.vnet_prd["name"]}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = [var.vnet_prd["iprange"]]

  tags = {
    environment = var.config_common["tag_environment_prd"]
    project = var.project_prefix
  }
}

resource "azurerm_subnet" "subnet_prd" {
  name                 = "${var.config_tagging_conventions["sub_net"]}-${var.subnet_prd["name"]}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet_prd.name
  address_prefix       = var.subnet_prd["iprange"]

  delegation {
    name = var.subnet_prd["delegation"]

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
  }
}