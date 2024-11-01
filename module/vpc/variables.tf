variable "region" {
  default = "us-east-1"
}

variable "availability_zones" {
  type = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type = list(string)
  default = ["10.0.1.0/24"]
}

variable "private_subnets" {
  type = list(string)
  default = ["10.0.2.0/24"]
}

variable "key_name" {
  default = "myssh"
}

variable "instance_ami" {
  default = "ami-0e86e20dae9224db8"
}
