#define variables

variable "primary_network_name" {
  type        = string
  description = "This is the primary network"
  default     = "primary"
}

variable "primary_network_cidr" {
  type        = list(string)
  description = "This is the primary network CIDR range"
  default     = ["10.0.0.0/16"]
}

variable "subnet_names" {
  type        = list(string)
  description = "subnet names"
  default     = ["web", "db", "app"]
}

variable "subnet_cidrs" {
  type        = list(string)
  description = "subnet cidrs"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "web_nsg_rules" {
  type = list(object({
    name                       = string
    description                = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    access                     = string
    priority                   = number
    }

  ))
  description = "web nsg rules"
  default = [{
    name                       = "openhttp"
    description                = "this opens 80 port"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    access                     = "Allow"
    priority                   = 1000
  }]
}







