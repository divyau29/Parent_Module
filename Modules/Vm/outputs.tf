# Virtual Machine Module: outputs.tf

output "vm_id" {
  value = azurerm_linux_virtual_machine.web.id
}

output "nic_id" {
  value = azurerm_network_interface.nic.id
}
