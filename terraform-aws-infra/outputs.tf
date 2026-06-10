# VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.my_vpc.id
}

# Subnet ID
output "subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.my_subnet.id
}

# EC2 Instance ID
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.instance_created_through_terraform[0].id
}

# EC2 Public IP
output "instance_public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.instance_created_through_terraform[0].public_ip
}

# EC2 Public DNS
output "instance_public_dns" {
  description = "Public DNS of EC2 instance"
  value       = aws_instance.instance_created_through_terraform[0].public_dns
}

# Security Group ID
output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.my_sg.id
}