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

# Create Network Security Group

resource "azurerm_network_security_group" "web" {
  name                = "webnsg"
  resource_group_name = azurerm_resource_group.group.name
  location            = azurerm_resource_group.group.location
  tags = {
    Name      = "poc"
    CreatedBy = "Terraform"
  }
  depends_on = [azurerm_resource_group.group]
}

# NSG rules

resource "azurerm_network_security_rule" "web" {
  count                       = length(var.web_nsg_rules)
  name                        = var.web_nsg_rules[count.index].name
  resource_group_name         = azurerm_resource_group.group.name
  network_security_group_name = azurerm_network_security_group.web.name
  description                 = var.web_nsg_rules[count.index].description
  protocol                    = var.web_nsg_rules[count.index].protocol
  source_port_range           = var.web_nsg_rules[count.index].source_port_range
  destination_port_range      = var.web_nsg_rules[count.index].destination_port_range
  source_address_prefix       = var.web_nsg_rules[count.index].source_address_prefix
  destination_address_prefix  = var.web_nsg_rules[count.index].destination_address_prefix
  access                      = var.web_nsg_rules[count.index].access
  priority                    = var.web_nsg_rules[count.index].priority
  direction                   = "Inbound"
  depends_on = [
    azurerm_network_security_group.web,
    azurerm_resource_group.group
  ]

}

# Creating NIC


