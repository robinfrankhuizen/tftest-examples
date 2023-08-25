output "storage_account" {
  value       = azurerm_storage_account.this
  description = "The created storage account."
  sensitive   = true
}

output "storage_container" {
  value       = azurerm_storage_container.this
  description = "The created storage container."
}
