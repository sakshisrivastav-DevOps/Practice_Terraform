# Difference Between a Root Module and a Child Module

## Root Module

A **root module** is the main Terraform configuration that Terraform executes directly. It is the module located in the directory where you run commands like `terraform init`, `terraform plan`, and `terraform apply`.

### Characteristics
- Acts as the entry point for a Terraform deployment.
- Executed directly by Terraform.
- Can contain resources, variables, outputs, and provider configurations.
- Can call one or more child modules.

### Example

```hcl
resource "aws_instance" "web" {
  ami           = "ami-12345678"
  instance_type = "t3.micro"
}
```

---

## Child Module

A **child module** is any module that is called by another module, usually the root module. Child modules are used to organize and reuse Terraform code.

### Characteristics
- Not executed directly.
- Invoked using a `module` block.
- Helps improve code reusability and maintainability.
- Can accept input variables and provide outputs.

### Example

**Root Module**

```hcl
module "ec2" {
  source = "./modules/ec2"

  instance_type = "t3.micro"
}
```

**Child Module (`./modules/ec2`)**

```hcl
resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = var.instance_type
}
```

---

## Key Differences

| Feature | Root Module | Child Module |
|----------|------------|-------------|
| Execution | Executed directly by Terraform | Called by another module |
| Purpose | Main entry point of deployment | Reusable infrastructure component |
| Location | Current working directory | Separate module directory or remote source |
| Invocation | Not called by another module | Invoked using a `module` block |
| Reusability | Usually project-specific | Designed for reuse |

---

## Summary

The **root module** is the primary Terraform configuration that Terraform runs directly. A **child module** is a reusable module that is called by the root module or another module. Root modules manage the overall deployment, while child modules help organize and reuse infrastructure code.
