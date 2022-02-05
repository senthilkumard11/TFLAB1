resource "azurerm_virtual_network" "az_vnet" {
  resource_group_name = azurerm_resource_group.az_dc_rg.name
  location            = azurerm_resource_group.az_dc_rg.location
  address_space       = ["10.1.0.0/16"]
  name                = var.vnet_name
  dns_servers = [ "10.1.0.10" ]

}

resource "azurerm_subnet" "core_sbnt" {
  resource_group_name  = azurerm_resource_group.az_dc_rg.name
  virtual_network_name = azurerm_virtual_network.az_vnet.name
  address_prefixes     = ["10.1.0.0/18"]
  name                 = var.core_sbnt_name

}

resource "azurerm_subnet" "az_sbnt" {
  resource_group_name  = azurerm_resource_group.az_dc_rg.name
  virtual_network_name = azurerm_virtual_network.az_vnet.name
  address_prefixes     = ["10.1.64.0/18"]
  name                 = var.app_sbnt_name

}


