output "bastion_host_public_ip" {
  description = "The public IP of the Bastion Host"
  value       = aws_instance.bastion_host.public_ip
}
output "bastion_sg_id" {
  description = "The bastion securty group id"
  value = aws_security_group.bastion_sg.id
}