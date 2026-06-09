# Region

provider "aws" {
    region = "us-west-2"
} 

# key value pair

resource "aws_key_pair" "deployer" {

    key_name = "deployer-key"
    public_key = file("/home/ubuntu/terra/Practice_Terraform/deployer-key.pub") #give correct path
  
}

#VPC default

resource "aws_default_vpc" "default" {
    tags = {

        Name = "default_vpc"
    }

}

#Security Group

resource "aws_security_group" "my_security_group" {
    description = "inbound & outbound rule for your security group"
    vpc_id = aws_default_vpc.default.id  #interpolation(import other value)

    tags = {
      Name = "deployer-security-group"
    }
}

# Inbound(ingress) & outbound(egress) port rule

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
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
  count = 3  #to create 3 instance
  ami  = "ami-0d13e2317a7e75c95"  #this take from aws of same above defined region, otherwise, it will throws an error, click on launch instance, you will see these value
  instance_type = "t3.micro"
  key_name = aws_key_pair.deployer.key_name  #attaching the key

  tags = {
    Name = "terra-automated-ec2"  #ec2-name
  }
  
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }
}