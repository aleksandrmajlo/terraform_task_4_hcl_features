resource "azurerm_linux_virtual_machine" "main" {
  count = var.vm_count

  name                = format("%s-vm-%02d", var.prefix, count.index + 1)
  computer_name       = format("%s-vm-%02d", var.prefix, count.index + 1)
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  size                = var.vm_size
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.main[local.nic_names[count.index]].id,
  ]

  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(pathexpand(var.ssh_public_key_path))
  }

  os_disk {
    name                 = format("%s-os-disk-%02d", var.prefix, count.index + 1)
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  tags = merge(local.common_tags, {
    instance = tostring(count.index + 1)
  })

  lifecycle {
    prevent_destroy = true
  }

  depends_on = [azurerm_network_interface_security_group_association.main]
}
