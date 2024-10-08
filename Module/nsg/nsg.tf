resource "azurerm_resource_group" "group" {
  name     = "poc"
  location = "eastus2"
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
