variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "A list of public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.0.0/25", "10.0.1.0/25"]
}

variable "private_subnets" {
  description = "Lista de blocos CIDR para sub-redes privadas"
  type        = list(string)
  default     = ["10.0.0.128/25", "10.0.1.128/25"]
}

variable "availability_zones" {
  description = "Lista de zonas de disponibilidade"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}


variable "key_name" {
  description = "The name of the key pair to use for the instance"
  type        = string
  default     = "myssh"
}

variable "instance_ami" {
  description = "The AMI to use for the instance"
  type        = string
  default     = "ami-0e86e20dae9224db8"
}

variable "db_name" {
  description = "The name of the database"
  type        = string
  default     = "north"
}

variable "db_username" {
  description = "The username for the database"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
  default     = "northpassword"
}

variable "allocated_storage" {
  description = "The allocated storage for the database"
  type        = number
  default     = 40
}

variable "db_instance_class" {
  description = "The instance class for the database"
  type        = string
  default     = "db.t2.micro"
}

variable "allow_rds_destroy" {
  description = "Flag to allow RDS instance to be destroyed"
  type        = bool
  default     = false
}