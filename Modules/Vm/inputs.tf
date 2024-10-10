# Virtual Machine Module: inputs.tf

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "location" {
  type        = string
  description = "The Azure region where resources will be created."
}

variable "vm_name" {
  type        = string
  description = "The name of the virtual machine."
}

variable "vm_size" {
  type        = string
  description = "The size of the virtual machine (e.g., Standard_DS1_v2)."
  default     = "Standard_B1s"
}

variable "vm_os_disk_size" {
  type        = number
  description = "The size of the OS disk for the virtual machine in GB."
  default     = 30
}

variable "vm_admin_username" {
  type        = string
  description = "The admin username for the virtual machine."
}

variable "vm_admin_password" {
  type        = string
  description = "The admin password for the virtual machine."
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet where the VM will be deployed."
}
