resource "azurerm_network_interface" "appnic" {
  count               = length(var.appsrname)
  name                = "nic_${count.index}"
  resource_group_name = azurerm_resource_group.az_rg.name
  location            = azurerm_resource_group.az_rg.location

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = data.azurerm_subnet.im_az_sbnt.id
    private_ip_address_allocation = "dynamic"
  }

}