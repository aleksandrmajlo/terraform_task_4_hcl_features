locals {
  # A list used by for_each to create one NIC for every planned VM.
  nic_names = [
    for index in range(var.vm_count) : format("%s-nic-%02d", var.prefix, index + 1)
  ]

  # Each object becomes one nested security_rule block in network.tf.
  security_rules = [
    {
      name                       = "AllowSSH"
      priority                   = 100
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "AllowHTTP"
      priority                   = 110
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
  ]

  common_tags = {
    environment = "training"
    managed_by  = "terraform"
    project     = "hcl-features"
  }
}
