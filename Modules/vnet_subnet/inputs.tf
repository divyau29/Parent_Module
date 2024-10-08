# inputs.tf (Module: vnet_subnet_vm)

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "location" {
  type        = string
  description = "The Azure region where resources will be created."
}

variable "vnet_name" {
  type        = string
  description = "The name of the Virtual Network."
}

variable "vnet_cidr" {
  type        = list(string)
  description = "The CIDR block for the Virtual Network."
}

variable "subnet_names" {
  type        = list(string)
  description = "A list of subnet names."
}

variable "subnet_cidrs" {
  type        = list(string)
  description = "A list of subnet CIDR blocks."
}