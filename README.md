# HCL Language Features with Terraform

This task involves utilizing various HCL language features such as count, for_each, Terraform lifecycle, dynamic blocks, and built-in functions.

## Prerequisites

- Basic understanding of Terraform and Azure.
- Terraform installed on your machine.
- Azure CLI installed and configured.

## Hands-on Task

1. Fork this repository.
2. Create multiple instances of a resource using the `count` meta-argument.
3. Create multiple network interfaces using the `for_each` meta-argument.
    * Add a resource block that creates multiple network interfaces using `for_each`.
    * Use a local value to define a list of network interface names.
    * Iterate over the list using `for_each` to create the resources.
4. Add a lifecycle block to prevent accidental virtual machine resource deletion.
5. Add dynamic blocks for network security rules.
    * Define a list of network security rules in a local value.
    * Use a dynamic block to iterate over the list and create the security rules.
6. Use built-in functions to manipulate strings and other data.
    * Create an output block that converts the virtual machine name to uppercase.
    * Create an output block that joins multiple tag values into a single string.
    * Create an output block that uses a for loop to get the IDs of all virtual machines.
7. Organize the Terraform code into multiple files for better readability and maintenance.

## Implemented solution

The configuration demonstrates every requested HCL feature:

- `count` creates the requested number of Linux virtual machines.
- `for_each` creates one network interface for every name in `local.nic_names`.
- `lifecycle.prevent_destroy` protects the virtual machines from accidental deletion.
- a dynamic `security_rule` block creates the NSG rules from
  `local.security_rules`.
- `upper`, `join`, and a `for` expression build the requested output values.

The configuration is split into focused files:

- `provider.tf` — Terraform and AzureRM provider settings;
- `variables.tf` — reusable input variables and validation;
- `locals.tf` — NIC names, security rules, and shared tags;
- `main.tf` — resource group;
- `network.tf` — VNet, subnet, NSG, NICs, and NSG associations;
- `compute.tf` — virtual machines;
- `outputs.tf` — examples of HCL built-in functions and expressions.

## Validate without creating Azure resources

This task's CI runs format and validation checks only. You can prepare the pull
request without creating billable Azure resources:

```bash
terraform init -backend=false
terraform fmt -check -recursive
terraform validate
```

## Optional deployment

To create the Azure resources locally, copy the example inputs and run a saved
plan:

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

The virtual machines have `prevent_destroy = true`, so a normal
`terraform destroy` intentionally fails. To clean up after testing, first change
that value to `false`, run `terraform apply`, and then run:

```bash
terraform destroy
```

