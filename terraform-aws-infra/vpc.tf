resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "TerraWeek-VPC"
  }
}

resource "aws_subnet" "my_subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.my_vpc.id
  map_public_ip_on_launch = true
  tags = {
    Name = "TerraWeek-Public-Subnet"
  }
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

  tags = {
    Name = "TerraWeek-SG"
  }
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
  ami  = "ami-0d13e2317a7e75c95"  #this take from aws of same above defined region, otherwise, it will throws an error, click on launch instance, you will see these value
  instance_type = "t2.micro"
  associate_public_ip_address = true
  subnet_id = aws_subnet.my_subnet.id
  key_name = "aws_key_pair.deployer.key_name"

  tags = {
    Name = "TerraWeek-Server"  #ec2-name
  }
  
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }
}
