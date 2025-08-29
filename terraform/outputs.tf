# Public IP of the EC2 instance
output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.dream_ec2.public_ip
}

# Public DNS of the EC2 instance
output "ec2_public_dns" {
  description = "Public DNS of the EC2 instance"
  value       = aws_instance.dream_ec2.public_dns
}

# VPC ID
output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.dream_vpc.id
}

# Subnet ID
output "subnet_id" {
  description = "Subnet ID"
  value       = aws_subnet.dream_subnet.id
}

# Security Group ID
output "security_group_id" {
  description = "Security Group ID"
  value       = aws_security_group.dream_sg.id
}

# AMI ID used for the EC2 instance
output "ec2_ami_id" {
  description = "AMI ID of the EC2 instance"
  value       = data.aws_ami.ubuntu.id
}