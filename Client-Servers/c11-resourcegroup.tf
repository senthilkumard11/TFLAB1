resource "azurerm_resource_group" "az_rg" {

  name     = var.resoure_group_name
  location = var.resource_group_location
}