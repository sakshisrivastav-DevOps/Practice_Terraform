# Module inputs

variable "vpc_id" {
    type = string
  
}

variable "sg_name" {
    type = string
  
}

variable "ingress_port" {
  type = list(number)
  default = [ 22,80]
}

variable "tags" {
    type = map(string)
    default = {}
}