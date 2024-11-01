# Saída do frontend SG
output "frontend_sg_id" {
  value = module.ec2.frontend_sg_id
}

# Saída do backend SG
output "backend_sg_id" {
  value = module.ec2.backend_sg_id
}

# Saída da instância Rancher (caso esteja no módulo ec2)
output "rancher_ec2_instance_id" {
  value = module.ec2.rancher_ec2_instance_id
}
