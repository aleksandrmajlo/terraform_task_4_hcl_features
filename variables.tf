variable "prefix" {
  description = "Short prefix used for all Azure resource names."
  type        = string
  default     = "mate-tf4"

  validation {
    condition     = can(regex("^[a-z0-9-]{3,20}$", var.prefix))
    error_message = "prefix must contain 3-20 lowercase letters, numbers, or hyphens."
  }
}

variable "location" {
  description = "Azure region in which the resources will be created."
  type        = string
  default     = "North Europe"
}

variable "vm_count" {
  description = "Number of virtual machines and network interfaces to create."
  type        = number
  default     = 2

  validation {
    condition     = var.vm_count >= 1 && var.vm_count <= 5 && floor(var.vm_count) == var.vm_count
    error_message = "vm_count must be a whole number from 1 to 5."
  }
}

variable "vm_size" {
  description = "Azure size used by every virtual machine."
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Administrator username for the Linux virtual machines."
  type        = string
  default     = "azureadmin"
}

variable "ssh_public_key_path" {
  description = "Path to the public SSH key installed on every VM."
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}
