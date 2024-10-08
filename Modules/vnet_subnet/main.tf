

resource "azurerm_virtual_network" "vnet" {
  name                = "primary"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.primary_network_cidr
  tags = {
    Environment = "Dev"
    CreatedBy   = "Terraform"
  }
}

# create multiple subnets
resource "azurerm_subnet" "subnets" {
  count                = length(var.subnet_names)
  name                 = var.subnet_names[count.index]
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_cidrs[count.index]]
  depends_on           = [azurerm_virtual_network.vnet]


}