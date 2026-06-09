## Key Concepts

### OpenTofu
- OpenTofu is an open-source alternative to Terraform.
- It was forked from Terraform to keep it fully open and community-driven.

---

### Terraform
- Terraform is an Infrastructure as Code (IaC) tool used to provision and manage infrastructure.
- It uses a **declarative approach**, where you define the desired state, and Terraform figures out how to achieve it.

---

### Declarative vs Imperative

- **Terraform (Declarative):**  
  You define *what* you want (end state), not *how* to achieve it.

- **Ansible (Imperative):**  
  You define *step-by-step instructions* to reach the desired state.

---

### CloudFormation

- CloudFormation is AWS’s native Infrastructure as Code (IaC) service.
- It is **limited to AWS**, meaning it cannot be used for multi-cloud environments.
- It uses templates (YAML/JSON) to define infrastructure.

---

## Quick Comparison

- Terraform → Multi-cloud, declarative IaC tool  
- OpenTofu → Open-source alternative of Terraform  
- Ansible → Imperative automation/configuration tool  
- CloudFormation → AWS-specific IaC tool  

# Formula of terraform

<block> <parameter> {
    argunments
}


## Explanation

- **Block**  
  Defines the type of configuration in Terraform.  

  **Examples:**
  - `resource` → create infrastructure  
  - `variable` → input values  
  - `output` → display results  
  - `data` → fetch existing info  

---

- **Parameter**  
  Identifies the block. It includes:

  - **Type** → what resource (e.g., `aws_instance`, `azurerm_vm`)  
  - **Name** → logical name given to the resource  

---

- **Arguments**  
  Key-value pairs inside the block that define the configuration.  
  They specify how the resource should be created.


## Provider (Terraform)

- A **provider** is a plugin that allows Terraform to interact with APIs of cloud platforms or services.
- It is used to create, manage, and provision resources.

---

### Examples
- AWS → `hashicorp/aws`  
- Azure → `hashicorp/azurerm`  
- GCP → `hashicorp/google`  

---

### Basic Syntax

```hcl
provider "aws" {
  region = "us-east-1"
}


## Terraform Provider vs Required Providers (Complete Notes)

```hcl
# Terraform Block (defines which provider to use and its version)
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"   # provider source (download from Terraform registry)
      version = "~> 5.0"          # version constraint (>= 5.0 and < 6.0)
    }
  }
}

# Provider Block (configures the provider)
provider "aws" {
  region = "us-west-2"            # region where resources will be created
}
```

# Explanation

- terraform {}  
  Used to define Terraform-level settings (providers, versions)

- required_providers  
  Defines which provider to use, its source, and version  
  Used during terraform init → downloads provider plugin  

- provider "aws"  
  Used to configure provider (region, credentials)  
  Used during terraform plan and apply  

# Version Meaning

- ~> 5.0 → >= 5.0 and < 6.0
- >= 5.0 → any higher version
- = 5.0.0 → exact version only 


# Key Difference

- required_providers → installs provider  
- provider → configures provider  

# Analogy

- required_providers → Install app  
- provider → Open app and set location 

## .terraform.lock.hcl (Short Notes)

```bash
.terraform.lock.hcl
```

# Explanation

- This file is **automatically created** after running `terraform init`
- It locks the **exact provider versions** used in your project
- Ensures all team members use the **same provider version**
- Prevents unexpected changes due to version upgrades
- Maintains consistency across different environments

# What it contains

- Provider name (e.g., aws)
- Exact version installed (e.g., 5.32.1)
- Checksums (for security verification)

# Why it is important

- Avoids "works on my machine" issues  
- Ensures reproducible deployments  
- Provides version stability in teams and CI/CD pipelines  

# Quick Note

- Do NOT delete this file in team projects  
- Commit it to Git  
- Guarantees same provider behavior everywhere  

.terraform.lock.hcl is created in the same directory where you run terraform init, alongside your Terraform configuration files.

```
VPC
 ├── Subnet
 ├── Internet Gateway
 └── Route Table
        └── Association with Subnet
``

## Terraform Dependency Questions

### 1. How does Terraform know to create the VPC before the subnet?

Terraform understands the order using **implicit dependencies**.

In your configuration:

```hcl
vpc_id = aws_vpc.my_vpc.id
```

- The subnet is referencing the VPC ID  
- Terraform automatically detects that **subnet depends on VPC**  
- So it creates the VPC first, then the subnet  

👉 No manual ordering is required

---

### 2. What would happen if you tried to create the subnet before the VPC existed?

- The subnet requires a valid `vpc_id`  
- If the VPC does not exist, AWS will return an error  

Example:
```
Error: VPC not found
```

👉 So Terraform would fail to create the subnet  

---

### 3. Implicit dependencies in this configuration

Terraform automatically creates dependencies wherever references are used:

```hcl
aws_subnet.my_subnet → depends on → aws_vpc.my_vpc
```

```hcl
aws_internet_gateway.my_gw → depends on → aws_vpc.my_vpc
```

```hcl
aws_route_table.my_rt → depends on → aws_vpc.my_vpc
```

```hcl
aws_route_table.my_rt → depends on → aws_internet_gateway.my_gw
```

```hcl
aws_route_table_association.my_rta → depends on → aws_subnet.my_subnet
```

```hcl
aws_route_table_association.my_rta → depends on → aws_route_table.my_rt
```

---

### Final Note

- Terraform builds a **dependency graph automatically**
- Order is determined using references (`resource.type.name.attribute`)
- This is called **implicit dependency**

# Terraform depends_on Notes

## What is depends_on?
- Explicit dependency defined manually
- Forces Terraform to create resources in a specific order

## Why use it?
- When Terraform cannot detect dependency automatically
- No direct reference exists between resources

## Syntax
depends_on = [resource_type.resource_name]

## Example
resource "aws_s3_bucket" "app_logs" {
  bucket = "terraweek-app-logs-12345"

  depends_on = [aws_instance.my_ec2]
}

## Types of Dependencies

### 1. Implicit Dependency
- Created automatically via attribute reference
- Example:
  vpc_id = aws_vpc.my_vpc.id

### 2. Explicit Dependency
- Manually defined using depends_on
- Used when no direct reference exists

## Real Use Cases

1. EC2 → S3 logging
- Ensure instance is created before log bucket

2. IAM Role → EC2
- Ensure role exists before attaching to instance

3. Infra → App deployment
- Deploy app only after infra is fully ready

## When NOT to use
- Avoid if dependency is already implicit
- Overuse leads to unnecessary delays

## Key Point
- depends_on overrides Terraform’s execution plan
- Use only when required

 terraform graph | dot -Tpng > graph.png

 This generates a visual dependency graph


 # Terraform Variable Types

 https://developer.hashicorp.com/terraform/language/values/variables

## 1. string
- Text values
- Example: "us-west-2"

## 2. number
- Numeric values
- Example: 10

## 3. bool
- True / False
- Example: true

## 4. list
- Ordered collection
- Example: [22, 80, 443]

## 5. map
- Key-value pairs
- Example:
  {
    Name = "test"
    Env  = "dev"
  }

  # Terraform Variables Questions & Answers

## Q1: What are variables in Terraform?
Variables are used to parameterize Terraform configurations, making them reusable and flexible instead of hardcoding values.

---

## Q2: What are the different types of variables in Terraform?
Terraform supports the following variable types:
- string
- number
- bool
- list
- map

---

## Q3: How do you define a variable in Terraform?

variable "region" {
  type    = string
  default = "us-west-2"
}

---

## Q4: How do you use a variable in Terraform?

provider "aws" {
  region = var.region
}

---

## Q5: How do you pass values to variables?

1. Using CLI:
terraform apply -var="region=us-east-1"

2. Using tfvars file:
terraform apply -var-file="dev.tfvars"

3. Environment variables

---

## Q6: What is a .tfvars file?
A `.tfvars` file is used to define variable values externally, making configurations environment-specific (dev, prod, etc.).

Example:
project_name = "terraweek"
environment  = "dev"

---

## Q7: What happens if a variable has no default value?
Terraform will prompt the user to enter a value during `terraform plan` or `apply`.

---

## Q8: What is the difference between variable and local in Terraform?

- Variable → Input provided by user
- Local → Computed value inside Terraform

Example:
locals {
  name = "${var.project}-dev"
}

---

## Q9: Why are variables important in real projects?

- Avoid hardcoding
- Enable reuse across environments
- Improve maintainability
- Support dynamic infrastructure

---


