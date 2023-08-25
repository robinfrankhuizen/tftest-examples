module "rg-tftest" {
  source   = "../../../resource-group"
  name     = var.name
  location = var.location
}