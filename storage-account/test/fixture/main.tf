resource "azurerm_resource_group" "rg-tftest" {
  location = "westeurope"
  name     = "rg-tftest"
}

module "st-tftest" {
  source                   = "../../../storage-account"
  account_tier             = "Standard"
  account_kind             = "BlobStorage"
  account_replication_type = "LRS"
  name                     = "sttftest645456"
  resource_group           = azurerm_resource_group.rg-tftest
  container_name           = "test"
}