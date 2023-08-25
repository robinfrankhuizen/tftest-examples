output "storage_account" {
  value     = module.st-tftest.storage_account
  sensitive = true
}

output "storage_container" {
  value = module.st-tftest.storage_container
}