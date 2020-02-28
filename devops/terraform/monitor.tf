#monitor containers
resource "random_id" "log_analytics_workspace_name_suffix" {
    byte_length = 8
}

resource "azurerm_log_analytics_workspace" "log_ws" {
  name                = "${var.config_tagging_conventions["log_ws"]}-${var.log_ws["name"]}-${random_id.log_analytics_workspace_name_suffix.dec}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.log_ws["sku"]
  retention_in_days   = var.log_ws["retention_in_days"]

  tags = {
    environment = var.config_common["tag_environment_prd"]
    project = var.project_prefix
  }
}

resource "azurerm_log_analytics_solution" "log_insights" {
  solution_name         = var.log_insights["solution_name"]
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  workspace_resource_id = azurerm_log_analytics_workspace.log_ws.id
  workspace_name        = azurerm_log_analytics_workspace.log_ws.name

  plan {
    publisher = var.log_insights["plan_publisher"]
    product   = var.log_insights["plan_product"]
  }

}

resource "azurerm_log_analytics_solution" "log_security" {
  solution_name         = var.log_security["solution_name"]
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  workspace_resource_id = azurerm_log_analytics_workspace.log_ws.id
  workspace_name        = azurerm_log_analytics_workspace.log_ws.name

  plan {
    publisher = var.log_security["plan_publisher"]
    product   = var.log_security["plan_product"]
  }

}