variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnets" {
  description = "Lista de subnets públicas"
  type        = list(string)
}

variable "private_subnets" {
  description = "Lista de subnets privadas"
  type        = list(string)
}

variable "key_name" {
  description = "Nome da chave SSH"
  type        = string
}

variable "instance_ami" {
  description = "ID da AMI para as instâncias"
  type        = string
}
