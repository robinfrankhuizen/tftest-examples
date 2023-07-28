module "tftest-rg" {
  source   = "../../../resource-group"
  name     = var.name
  location = var.location
}