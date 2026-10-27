output "uppercase_first_vm_name" {
  description = "The first virtual machine name converted to uppercase."
  value       = upper(azurerm_linux_virtual_machine.main[0].name)
}

output "joined_tag_values" {
  description = "All common tag values joined into one comma-separated string."
  value       = join(", ", values(local.common_tags))
}

output "virtual_machine_ids" {
  description = "IDs of all virtual machines, collected with a for expression."
  value       = [for vm in azurerm_linux_virtual_machine.main : vm.id]
}

output "network_interface_names" {
  description = "NIC names created with for_each."
  value       = sort(keys(azurerm_network_interface.main))
}
