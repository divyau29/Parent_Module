resource "azurerm_resource_group" "group" {
  name     = "poc"
  location = "eastus2"
  tags = {
    Name      = "poc"
    CreatedBy = "Terraform"
  }

}