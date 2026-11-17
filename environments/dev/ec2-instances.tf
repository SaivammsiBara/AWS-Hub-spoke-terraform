
# ==========================================
# Find the latest official Ubuntu 24.04 AMI
# ==========================================

data "aws_ami" "ubuntu_2404" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}


# ==========================================
# Production EC2 - Availability Zone A
# ==========================================

resource "aws_instance" "production_1" {
  ami                    = data.aws_ami.ubuntu_2404.id
  instance_type          = "t3.micro"
  ebs_optimized          = true
  subnet_id              = module.network.production_private_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.production_ec2.id]

  associate_public_ip_address = false

  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    encrypted = true
  }

  tags = {
    Name    = "Production-EC2-1"
    Project = "Hub-and-Spoke"
  }
}


# ==========================================
# Production EC2 - Availability Zone B
# ==========================================

resource "aws_instance" "production_2" {
  ami                    = data.aws_ami.ubuntu_2404.id
  instance_type          = "t3.micro"
  ebs_optimized          = true
  subnet_id              = module.network.production_private_subnet_ids[1]
  vpc_security_group_ids = [aws_security_group.production_ec2.id]

  associate_public_ip_address = false

  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    encrypted = true
  }

  tags = {
    Name    = "Production-EC2-2"
    Project = "Hub-and-Spoke"
  }
}


# ==========================================
# Development EC2 - Availability Zone A
# ==========================================

resource "aws_instance" "development_1" {
  ami                    = data.aws_ami.ubuntu_2404.id
  instance_type          = "t3.micro"
  ebs_optimized          = true
  subnet_id              = module.network.development_private_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.development_ec2.id]

  associate_public_ip_address = false

  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    encrypted = true
  }

  tags = {
    Name    = "Development-EC2-1"
    Project = "Hub-and-Spoke"
  }
}


# ==========================================
# Development EC2 - Availability Zone B
# ==========================================

resource "aws_instance" "development_2" {
  ami                    = data.aws_ami.ubuntu_2404.id
  instance_type          = "t3.micro"
  ebs_optimized          = true
  subnet_id              = module.network.development_private_subnet_ids[1]
  vpc_security_group_ids = [aws_security_group.development_ec2.id]

  associate_public_ip_address = false

  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    encrypted = true
  }

  tags = {
    Name    = "Development-EC2-2"
    Project = "Hub-and-Spoke"
  }
}


# ==========================================
# Shared Services EC2 - Availability Zone A
# ==========================================

resource "aws_instance" "shared_services_1" {
  ami                    = data.aws_ami.ubuntu_2404.id
  instance_type          = "t3.micro"
  ebs_optimized          = true
  subnet_id              = module.network.shared_private_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.shared_services_ec2.id]

  associate_public_ip_address = false

  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    encrypted = true
  }

  tags = {
    Name    = "Shared-Services-EC2-1"
    Project = "Hub-and-Spoke"
  }
}


# ==========================================
# Shared Services EC2 - Availability Zone B
# ==========================================

resource "aws_instance" "shared_services_2" {
  ami                    = data.aws_ami.ubuntu_2404.id
  instance_type          = "t3.micro"
  ebs_optimized          = true
  subnet_id              = module.network.shared_private_subnet_ids[1]
  vpc_security_group_ids = [aws_security_group.shared_services_ec2.id]

  associate_public_ip_address = false

  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    encrypted = true
  }

  tags = {
    Name    = "Shared-Services-EC2-2"
    Project = "Hub-and-Spoke"
  }
}
