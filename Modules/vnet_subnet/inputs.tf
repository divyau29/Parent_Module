# Define Variables

variable "resource_group_name" {
  type = string
  default = "practice1"
}

variable "location" {
  type = string
  default = "eastus2"
}

variable "primary_network_cidr" {
  type        = list(string)
  description = "This is primary networks cidr range"
  default     = ["192.168.0.0/16"]
}

variable "subnet_names" {
  type        = list(string)
  description = "subnet names"
  default     = ["web", "app", "db"]
}

variable "subnet_cidrs" {
  type        = list(string)
  description = "subnet cidrs"
  default     = ["192.168.0.0/24", "192.168.1.0/24", "192.168.2.0/24"]
}
