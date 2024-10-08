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








