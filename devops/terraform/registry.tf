# Create container registry for docker images
resource "azurerm_container_registry" "acr" {
  name                = "${var.config_tagging_conventions["registry"]}${var.registry_common["name"]}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = var.registry_common["sku"]
  admin_enabled       = var.registry_common["admin_enabled"]
  

  tags = {
    environment = var.config_common["tag_environment_prd"]
    project = var.project_prefix
  }
}