# Create Storages
resource "azurerm_storage_account" "storage_dev" {
  name                     = "${var.config_tagging_conventions["storage"]}${var.storage_dev["name"]}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = var.storage_dev["tier"]
  account_replication_type = var.storage_dev["replication_type"]

  tags = {
    environment = var.config_common["tag_environment_dev"]
    project = var.project_prefix
  }
}

resource "azurerm_storage_account" "storage_prd" {
  name                     = "${var.config_tagging_conventions["storage"]}${var.storage_prd["name"]}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = var.storage_prd["tier"]
  account_replication_type = var.storage_prd["replication_type"]

  tags = {
    environment = var.config_common["tag_environment_prd"]
    project = var.project_prefix
  }
}