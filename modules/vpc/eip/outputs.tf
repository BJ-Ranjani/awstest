output "id" {
  description = "Contains the EIP allocation ID"
  value       = aws_eip.this.*.id
}

output "public_ip" {
  description = "Contains the public IP address"
  value       = aws_eip.this.*.public_ip
}

output "public_dns" {
  description = "Public DNS associated with the Elastic IP address"
  value       = aws_eip.this.*.public_dns
}