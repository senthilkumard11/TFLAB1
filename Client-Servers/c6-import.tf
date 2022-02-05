data "azurerm_resource_group" "im_rg" {
  name = "Core-Services-RG"
}


data "azurerm_virtual_network" "im_vnet" {
  name                = "Core-vNet"
  resource_group_name = data.azurerm_resource_group.im_rg.name
}

data "azurerm_subnet" "im_dc_sbnt" {
  name                 = "core-sbnt"
  resource_group_name  = data.azurerm_resource_group.im_rg.name
  virtual_network_name = data.azurerm_virtual_network.im_vnet.name
}

data "azurerm_subnet" "im_az_sbnt" {
  name                 = "app-sbnt"
  resource_group_name  = data.azurerm_resource_group.im_rg.name
  virtual_network_name = data.azurerm_virtual_network.im_vnet.name
}