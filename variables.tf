variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
}

variable "disk_name" {
  description = "The name of the managed disk"
  type        = string
}

variable "storage_account_type" {
  description = "The type of storage account to use (e.g., Standard_LRS, Premium_LRS)"
  type        = string
}

variable "disk_size_gb" {
  description = "The size of the managed disk in GB"
  type        = number
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}