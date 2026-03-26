output "instance_id" {
  description = "ID of the compute instance"
  value       = aws_instance.compute.id
}

output "public_ip" {
  description = "Elastic IP address of the compute instance"
  value       = aws_eip.compute.public_ip
}

output "security_group_id" {
  description = "ID of the compute security group"
  value       = aws_security_group.compute.id
}
