# Built a complete AWS infrastructure using Terraform, including VPC, subnet, internet gateway, route tables, security groups, and EC2 instance, all connected through dependency graphs where Terraform manages execution order. Enhanced the configuration to be fully dynamic and production-ready by introducing variables for environment-specific inputs, data sources for dynamic AMI selection, locals for consistent naming and tagging, and conditional expressions for adaptive resource sizing—resulting in a reusable, zero hardcoded Terraform setup.

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  #cidr_block = "10.0.0.0/16"
  # tags = {
  #   Name = "TerraWeek-VPC"
  # }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-vpc"
  })
}

resource "aws_subnet" "my_subnet" {
  #cidr_block = "10.0.1.0/24"
  
  cidr_block = var.subnet_cidr
  vpc_id     = aws_vpc.my_vpc.id

  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
#   tags = {
#     Name = "TerraWeek-Public-Subnet"
#   }
# }


  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-subnet"
  })
}

resource "aws_internet_gateway" "my_gw" {
vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "my_rt" {
vpc_id = aws_vpc.my_vpc.id

route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_gw.id
  }
 
}

resource "aws_route_table_association" "my_rta" {
  route_table_id = aws_route_table.my_rt.id
  subnet_id      = aws_subnet.my_subnet.id
}

resource "aws_security_group" "my_sg" {
  description = "Allow inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  # tags = {
  #   Name = "TerraWeek-SG"
  # }
  
tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-sg"
  })

}

# Inbound(ingress) & outbound(egress) port rule

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.my_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.my_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.my_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports

}

resource "aws_key_pair" "deployer" {

    key_name = "deployer-key"
    public_key = file("/home/ubuntu/terra/Practice_Terraform/deployer-key.pub") #give correct path
}

resource "aws_instance" "instance_created_through_terraform" {
  count = 1 
  ami = data.aws_ami.amazon_linux.id
  #ami  = "ami-0fe18bc3cfa53a248"  #this take from aws of same above defined region, otherwise, it will throws an error, click on launch instance, you will see these value
  instance_type = "t3.micro"
  associate_public_ip_address = true
  subnet_id = aws_subnet.my_subnet.id
  key_name = aws_key_pair.deployer.key_name

  # tags = {
  #   Name = "TerraWeek-Server"  #ec2-name
  # }
  
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-server"
  
  })

  lifecycle {
    create_before_destroy = true
  }

  vpc_security_group_ids = [aws_security_group.my_sg.id]
  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }
}

resource "aws_s3_bucket" "applog" {
  bucket = "terraweek-app-logs"  #actual bucket name in AWS, must be unique globally
  depends_on = [aws_instance.instance_created_through_terraform]
  tags = {
    Name  = "My bucket"

  }
}