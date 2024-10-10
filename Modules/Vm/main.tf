# Virtual Machine Module: main.tf

resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  resource_group_name  = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "${var.vm_name}-ipconfig"
    subnet_id                    = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
  name                         = var.vm_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  network_interface_ids       = [azurerm_network_interface.nic.id]
  vm_size                      = var.vm_size
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_os_disk {
    name              = var.vm_name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    disk_size_gb      = var.vm_os_disk_size
  }

  os_profile {
    computer_name = var.vm_name
    admin_username = var.vm_admin_username
    admin_password = var.vm_admin_password
  }

  os_profile_windows_config {
    provision_vm_agent = true
  }

  tags = {
    CreatedBy = "Terraform"
  }
}
