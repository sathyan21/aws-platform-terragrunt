resource "aws_security_group" "compute" {
  name        = "aws-platform-compute-sg"
  description = "Security group for compute instances"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "aws-platform-compute-sg"
    Environment = var.environment
  }
}

resource "aws_instance" "compute" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  vpc_security_group_ids = [aws_security_group.compute.id]

  root_block_device {
    volume_size = 50
    volume_type = "gp3"
  }

  tags = {
    Name        = "aws-platform-compute"
    Environment = var.environment
  }
}

resource "aws_eip" "compute" {
  instance = aws_instance.compute.id
  domain   = "vpc"

  tags = {
    Name        = "aws-platform-compute-eip"
    Environment = var.environment
  }
}
