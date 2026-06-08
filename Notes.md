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
