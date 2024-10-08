# creating multiple subnets

resource "azurerm_subnet" "subnets" {
  count                = length(var.subnet_names)
  name                 = var.subnet_names[count.index]
  resource_group_name  = azurerm_resource_group.group.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.subnet_cidrs[count.index]]
  depends_on = [
    azurerm_resource_group.group,
    azurerm_virtual_network.main
  ]

}