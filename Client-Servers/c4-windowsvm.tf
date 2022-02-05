### APP Servers deployment
resource "azurerm_windows_virtual_machine" "az_appvm" {
  count               = length(var.appsrname)
  name                = var.appsrname[count.index]
  resource_group_name = azurerm_resource_group.az_rg.name
  location            = azurerm_resource_group.az_rg.location
  size                = "Standard_D4s_v4"
  admin_username      = "localadmin"
  admin_password      = "Cloudteam@2019!"
  network_interface_ids = [
    azurerm_network_interface.appnic.*.id[count.index],
  ]


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

}

### Managed disks for App Servers

resource "azurerm_managed_disk" "appdisk" {
  count                = length(var.appsrname)
  name                 = "data_disk_${count.index}"
  resource_group_name  = azurerm_resource_group.az_rg.name
  location             = azurerm_resource_group.az_rg.location
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = "128"


  tags = {
    environment = "staging"
  }
}

resource "azurerm_virtual_machine_data_disk_attachment" "appdisk_attach" {
  count              = length(var.appsrname)
  managed_disk_id    = element(azurerm_managed_disk.appdisk[*].id, count.index)
  virtual_machine_id = element(azurerm_windows_virtual_machine.az_appvm[*].id, count.index)
  lun                = "10"
  caching            = "ReadWrite"
}


### App Server Domain Join

resource "azurerm_virtual_machine_extension" "domjoin" {
  name                 = "domjoin"
  count                = length(var.appsrname)
  virtual_machine_id   = element(azurerm_windows_virtual_machine.az_appvm[*].id, count.index)
  publisher            = "Microsoft.Compute"
  type                 = "JsonADDomainExtension"
  type_handler_version = "1.3"
  settings             = <<SETTINGS
{
"Name": "devops.com",
"OUPath": "OU=Servers,DC=devops,DC=com",
"User": "devops\\senthil",
"Restart": "true",
"Options": "3"
}
SETTINGS
  protected_settings   = <<PROTECTED_SETTINGS
{
"Password": "P@ssw0rd@123"
}
PROTECTED_SETTINGS
}

/*
module "domain-join-appsrv-1" {
  source  = "kumarvna/domain-join/azurerm"
  version = "1.0.0"
  #count              = length(var.appsrname)
  #virtual_machine_id        = element(azurerm_windows_virtual_machine.az_appvm[*].id, count.index)
  active_directory_domain   = "devops.com"
  active_directory_username = "senthil"
  active_directory_password = "P@ssw0rd@123"

  # Adding TAG's to your Azure resources (Required)
  # ProjectName and Env are already declared above, to use them here or create a varible. 

}*/

