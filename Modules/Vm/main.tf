# Virtual Machine Module: main.tf


resource "azurerm_public_ip" "public_ip" {
  name                = "${var.vm_name}-public-ip"
  resource_group_name  = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
  sku                  = "Basic"
}

resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  resource_group_name  = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "${var.vm_name}-ipconfig"
    subnet_id                    = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id         = azurerm_public_ip.public_ip.id
  }
}



resource "azurerm_linux_virtual_machine" "web" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  disable_password_authentication = "false"
  admin_username      = var.vm_admin_username
  admin_password = var.vm_admin_password
  network_interface_ids = [azurerm_network_interface.nic.id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = "latest"
  }

}

# resource "azurerm_virtual_machine" "vm" {
#   name                         = var.vm_name
#   resource_group_name          = var.resource_group_name
#   location                     = var.location
#   network_interface_ids       = [azurerm_network_interface.nic.id]
#   vm_size                      = var.vm_size
#   delete_os_disk_on_termination = true
#   delete_data_disks_on_termination = true

#   storage_os_disk {
#     name              = var.vm_name
#     # caching           = "ReadWrite"
#     create_option     = "FromImage"
#     # disk_size_gb      = var.vm_os_disk_size
#   }

#   os_profile {
#     computer_name = var.vm_name
#     admin_username = var.vm_admin_username
#     admin_password = var.vm_admin_password
#   }

#   # os_profile_windows_config {
#   #   provision_vm_agent = true
#   # }

#    os_profile_linux_config {
#     disable_password_authentication = false  # Allows password authentication for Linux
#   }

#   # Reference to Ubuntu image in Azure marketplace
#   storage_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer" #"UbuntuServer"
#     sku       = "20.04-LTS"  # You can change to 22.04-LTS or any other supported version
#     version   = "2023.08.22"
#   }

#   tags = {
#     CreatedBy = "Terraform"
#   }
# }
