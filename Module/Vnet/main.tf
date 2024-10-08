resource "azurerm_resource_group" "group" {
  name     = "poc"
  location = "eastus2"
  tags = {
    Name      = "poc"
    CreatedBy = "Terraform"
  }

}


# Creating Azure Virtual network

resource "azurerm_virtual_network" "main" {
  name                = var.primary_network_name
  address_space       = var.primary_network_cidr
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name
  tags = {
    Name      = "poc"
    CreatedBy = "Terraform"
  }
  depends_on = [azurerm_resource_group.group]
}

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

# Create public ip address

resource "azurerm_public_ip" "web" {
  name                = "webip"
  resource_group_name = azurerm_resource_group.group.name
  location            = azurerm_resource_group.group.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    Name      = "poc"
    CreatedBy = "Terraform"
  }
}