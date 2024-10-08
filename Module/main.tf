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