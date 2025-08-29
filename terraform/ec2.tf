########################################
# Key Pair
########################################`
resource "aws_key_pair" "dream_key" {
  key_name   = "dream-key"
  public_key = file("${path.module}/dream-key.pub")
}

########################################
# Security Group
########################################
resource "aws_security_group" "dream_sg" {
  name        = "dream-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.dream_vpc.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dream-sg"
  }
}

resource "aws_instance" "dream_ec2" {
  ami                    = "ami-0360c520857e3138f"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.dream_subnet.id
  vpc_security_group_ids = [aws_security_group.dream_sg.id]
  key_name               = aws_key_pair.dream_key.key_name

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "dream-ec2"
  }

  iam_instance_profile = aws_iam_instance_profile.cw_instance_profile.name
}