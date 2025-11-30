output "web_server_public_ip" {
  description = "Public IP address of the web server"
  value       = aws_instance.web_server.public_ip
}

output "web_server_private_ip" {
  description = "Private IP address of the web server"
  value       = aws_instance.web_server.private_ip
}

output "db_server_private_ip" {
  description = "Private IP address of the database server"
  value       = aws_instance.db_server.private_ip
}

output "ssh_connection_command" {
  description = "SSH command to connect to the web server"
  value       = "ssh -i kardoc.pem ec2-user@${aws_instance.web_server.public_ip}"
}
