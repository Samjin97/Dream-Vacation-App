variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "key_name" {
  description = "Existing EC2 key pair name (created manually)"
  type        = string
  default = "dream-key"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "docker_compose_file_dest" {
  type    = string
  default = "/home/ubuntu/docker-compose.yml"
}
