variable "name" {
  type = string

  validation {
    condition     = substr(var.name, 0, 3) == "rg-"
    error_message = "The name of the resource group must start with rg-."
  }
}

variable "location" {
  type    = string
  default = "westeurope"
}