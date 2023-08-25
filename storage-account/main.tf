resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = local.resource_group_name
  location                 = local.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  account_kind             = var.account_kind
}

resource "azurerm_storage_container" "this" {
  name                 = var.container_name
  storage_account_name = azurerm_storage_account.this.name
}

resource "azurerm_role_assignment" "this" {
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = "e8a5724c-7603-42e0-91f0-c843e5c3c17e"
  scope                = azurerm_storage_account.this.id
}
