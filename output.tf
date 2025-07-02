output "managed_disk_id" {
  description = "The ID of the managed disk"
  value       = azurerm_managed_disk.example.id
}

output "managed_disk_name" {
  description = "The name of the managed disk"
  value       = azurerm_managed_disk.example.name
}

output "managed_disk_resource_group" {
  description = "The resource group of the managed disk"
  value       = azurerm_managed_disk.example.resource_group_name
}

output "managed_disk_location" {
  description = "The location of the managed disk"
  value       = azurerm_managed_disk.example.location
}