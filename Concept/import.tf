import {
    id = "abc"
    to = aws_instance.my_existing_instance
}


resource "aws_instance" "my_existing_instance" {
  ami = "ami-0d13e2317a7e75c95" #provide details of existing ec2 from aws
  instance_type = "t3.micro"
  key_name = "deployer-key"
}