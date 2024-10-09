# Virtual Network and Subnet Module: outputs.tf

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "subnet_ids" {
  value = azurerm_subnet.subnets[*].id
}
