
# outputs.tf (Module: vnet_subnet_vm)

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "subnet_ids" {
  value = azurerm_subnet.subnets[*].id
}

