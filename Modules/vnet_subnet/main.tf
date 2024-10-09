# Virtual Network and Subnet Module: main.tf

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name  = var.resource_group_name
  location            = var.location
  address_space       = var.vnet_cidr
  tags = {
    CreatedBy   = "Terraform"
  }
}

resource "azurerm_subnet" "subnets" {
  count                = length(var.subnet_names)
  name                 = var.subnet_names[count.index]
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_cidrs[count.index]]
}


