# Create Virtual Machine
resource "azurerm_linux_virtual_machine" "virtual_machine" {
  name                = "vm-${var.tenant_name}"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  size                = var.vm_size
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.network_interface.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = var.tenant_pem
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.vm_disk_size
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

resource "azurerm_network_interface_security_group_association" "security_group_test_association" {
  network_interface_id      = azurerm_network_interface.network_interface.id
  network_security_group_id = azurerm_network_security_group.security_group.id
}
