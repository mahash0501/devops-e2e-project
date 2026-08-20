output "server_public_ip" {
  description = "Public IP of the DevOps server"
  value       = aws_instance.devops_server.public_ip
}

output "jenkins_url" {
  description = "Jenkins web console URL"
  value       = "http://${aws_instance.devops_server.public_ip}:8080"
}

output "sonarqube_url" {
  description = "SonarQube web console URL"
  value       = "http://${aws_instance.devops_server.public_ip}:9000"
}
