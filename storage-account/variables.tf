variable "name" {
  type        = string
  description = "The name of the storage account."
}

variable "resource_group" {
  type        = any # must be azurerm_resource_group
  description = "The resource group in which this storage account will be deployed."
}

variable "account_tier" {
  type        = string
  default     = "Standard"
  description = "The tier of the storage account. Must be one of: Standard, Premium."
  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "account_tier must be one of: Standard, Premium."
  }
}

variable "account_replication_type" {
  type        = string
  description = "The replication type of the storage account. Must be one of: LRS, GRS."

  # Policy: only allow LRS, GRS
  validation {
    condition     = contains(["LRS", "GRS"], var.account_replication_type)
    error_message = "account_replication_tier must be one of: LRS, GRS."
  }
}

variable "account_kind" {
  type        = string
  description = "The kind of storage account. Must be one of: BlobStorage, FileStorage, StorageV2."

  # Policy: only allow BlobStorage, FileStorage, StorageV2
  validation {
    condition     = contains(["BlobStorage", "FileStorage", "StorageV2"], var.account_kind)
    error_message = "account_tier must be one of: BlobStorage, FileStorage, StorageV2."
  }
}

variable "container_name" {
  type        = string
  description = "The name of the storage container."
}
