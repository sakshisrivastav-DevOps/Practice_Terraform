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


provider -->
