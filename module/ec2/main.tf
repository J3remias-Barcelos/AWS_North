# Instância pública (Frontend)
resource "aws_instance" "frontend" {
  ami           = var.instance_ami
  instance_type = "t2.micro"
  key_name      = var.key_name
  subnet_id     = var.public_subnets[0]  # Usando a primeira subnet pública
  security_groups = [aws_security_group.frontend_sg.id]
  tags = {
    Name = "frontend-instance"
  }
}

# Instância privada (Backend)
resource "aws_instance" "backend" {
  ami           = var.instance_ami
  instance_type = "t2.medium"
  key_name      = var.key_name
  subnet_id     = var.private_subnets[0]  # Usando a primeira subnet privada
  security_groups = [aws_security_group.backend_sg.id]
  tags = {
    Name = "backend-instance"
  }
}

# Instância pública (Rancher)
resource "aws_instance" "rancher" {
  ami           = var.instance_ami
  instance_type = "t2.micro"
  key_name      = var.key_name
  subnet_id     = var.public_subnets[0]  # Usando a mesma subnet pública que o frontend
  security_groups = [aws_security_group.frontend_sg.id]  # Pode compartilhar o mesmo SG do frontend
  tags = {
    Name = "rancher-instance"
  }
}

# Grupo de Segurança para Frontend
resource "aws_security_group" "frontend_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Acesso SSH liberado globalmente
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "frontend-sg"
  }
}

# Grupo de Segurança para Backend
resource "aws_security_group" "backend_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Restringe o acesso SSH ao range de IPs da VPC
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "backend-sg"
  }
}

output "frontend_ec2_id" {
  value = aws_instance.frontend.id
}

output "backend_ec2_id" {
  value = aws_instance.backend.id
}

# Opcional: Output para a instância Rancher, se necessário
output "rancher_ec2_id" {
  value = aws_instance.rancher.id
}
