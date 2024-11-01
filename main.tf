# Provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Módulo VPC
module "vpc" {
  source = "./module/vpc"
  # Parâmetros de configuração do módulo VPC
}

# Módulo EC2
module "ec2" {
  source         = "./module/ec2"
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets  # Envie a lista completa de subnets públicas
  private_subnets = module.vpc.private_subnets  # Envie a lista completa de subnets privadas
  key_name       = var.key_name
  instance_ami   = var.instance_ami
}


# Internet Gateway para a VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = module.vpc.vpc_id
  tags = {
    Name = "InternetGateway"
  }
}

# NAT Gateway e EIP para acesso das instâncias privadas
resource "aws_eip" "nat_eip" {
  associate_with_private_ip = true
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = module.vpc.public_subnets[0]
  tags = {
    Name = "NATGateway"
  }
}

# Rotas e associações para sub-redes públicas e privadas
resource "aws_route_table" "public_rt" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_subnet_assoc" {
  for_each = toset(module.vpc.public_subnets)
  subnet_id      = each.value
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}

resource "aws_route_table_association" "private_subnet_assoc" {
  for_each = toset(module.vpc.private_subnets)
  subnet_id      = each.value
  route_table_id = aws_route_table.private_rt.id
}
