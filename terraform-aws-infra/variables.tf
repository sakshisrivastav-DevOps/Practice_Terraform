variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "environment" {
    type = string
    default = "dev"
  
}

variable "region" {
  type = string
  default = "us-east-2"
}

variable "subnet_cidr" {
    type = string
    default = "10.0.0.0/24"
}

variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
  
}

variable "project_name" {
    type = string
  
}

variable "allowed_ports" {
    type = list(number)
    default = [22,80,443]
}

variable "extra_tags" {
    type = map(string)
    default = {}
  
}