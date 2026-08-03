output "instance_public_ip" {
  description = "Public IP of the deployed EC2 instance"
  value       = aws_instance.dream_app_server.public_ip
}

output "instance_id" {
  value = aws_instance.dream_app_server.id
}

output "vpc_id" {
  value = aws_vpc.dream_vpc.id
}

output "subnet_id" {
  value = aws_subnet.dream_subnet.id
}
