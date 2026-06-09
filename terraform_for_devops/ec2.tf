# Region

provider "aws" {
    region = "us-west-2"
} 

# key value pair

resource "aws_key_pair" "deployer" {

    key_name = "deployer-key"
    public_key = file("deployer-key.pub")
  
}

#VPC default

resource "aws_default_vpc" "default" {
    tags = {

        Name = "default_vpc"
    }

}

#Security Group

resource "aws_security_group" "my_security_group" {
    name = "deployer-security-group"
    description = "inbound & outbound rule for your security group"
    vpc_id = aws_default_vpc.default.id  #interpolation(import other value)
}

# Inbound(ingress) & outbound(egress) port rule

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = aws_default_vpc.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# EC2 Instance

resource "aws_instance" "instance_created_through_terraform" {
 
  ami  = "ami-0a59248a6294cece2"  #this take from aws, click on launch instance, you will see these value
  instance_type = "t3.micro"

  tags = {
    name = "terra-automated-ec2"  #ec2-name
  }
  
 
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }
}