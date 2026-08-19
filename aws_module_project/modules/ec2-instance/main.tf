# EC2 resource definition
#Built my first custom Terraform modules.
# EC2 and security group modules called multiple times with different configs. Then replaced 50 lines of VPC code with one registry module. Modules are the key to scalable infrastructure as code

resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  tags = merge(
    var.tags,
    {
      Name = var.instance_name
    }
  )
}
