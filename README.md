# Terraform Learning Repository

This repository serves as a comprehensive guide for DevOps Engineers to learn Terraform.

It covers concepts ranging from basic fundamentals to advanced features, along with practical implementations using real AWS infrastructure.

# Prerequisites
1. AWS Account

# Official Website:

https://developer.hashicorp.com/terraform

## Versions Used

- **Terraform:** = 1.15.5

- **AWS Provider:** ~> 6.0  

- **EKS Module:** ~> 21.0  

- **VPC Module:** ~> 5.0  

## Terraform Installation (Ubuntu)

Please refere official website for installation

```bash
wget -O - https://apt.releases.hashicorp.com/gpg \   # Downloads the HashiCorp GPG key and outputs it
| sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg   # Converts the key to binary format and saves it securely

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" \   # Adds HashiCorp repo with system architecture and Ubuntu version
| sudo tee /etc/apt/sources.list.d/hashicorp.list   # Writes the repository details into apt sources list

sudo apt update && sudo apt install terraform   # Updates package list and installs Terraform

terraform -v # to check terraform version

## Initialize Terraform

```bash
terraform init   # Initializes working directory and downloads required provider plugins
``

## Core Commands

terraform fmt                       # Format code to standard style
terraform validate                  # Validate syntax and configuration
terraform plan                      # Preview changes without applying
terraform apply                     # Create/update infrastructure
terraform apply -auto-approve       # Apply without confirmation
terraform destroy                   # Destroy all managed resources
terraform destroy -auto-approve     # Destroy without confirmation

# Other Imp Command

terraform show                      # Display current state or execution plan
terraform state list               # List all resources in state file
terraform state show <resource>    # Show details of a specific resource
terraform output                   # Display output variables
terraform output instance_public_ip #specific thing
terraform output -json 
terraform refresh                  # Update state file with real infrastructure (deprecated but still used)
terraform taint <resource>         # Mark resource for recreation
terraform untaint <resource>       # Remove taint from resource
terraform import <addr> <id>       # Import existing resource into Terraform
terraform workspace list           # List all workspaces
terraform workspace new <name>     # Create new workspace
terraform workspace select <name>  # Switch workspace
terraform providers                # Show required providers
terraform graph                    # Generate dependency graph

