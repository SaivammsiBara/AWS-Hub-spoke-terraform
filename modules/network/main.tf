resource "aws_vpc" "production" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "Production-VPC"
    Environment = "Production"
    Project     = "Hub-and-Spoke"
  }
}
resource "aws_vpc" "development" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "Development-VPC"
    Environment = "Development"
    Project     = "Hub-and-Spoke"
  }
}

resource "aws_vpc" "shared_services" {
  cidr_block           = "10.2.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "Shared-Services-VPC"
    Environment = "Shared-Services"
    Project     = "Hub-and-Spoke"
  }
}
resource "aws_subnet" "production_private_1" {
  vpc_id                  = aws_vpc.production.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = false

  tags = {
    Name        = "Production-Private-1"
    Environment = "Production"
  }
}
resource "aws_subnet" "production_private_2" {
  vpc_id                  = aws_vpc.production.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = false

  tags = {
    Name        = "Production-Private-2"
    Environment = "Production"
  }
}

resource "aws_subnet" "development_private_1" {
  vpc_id                  = aws_vpc.development.id
  cidr_block              = "10.1.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = false

  tags = {
    Name        = "Development-Private-1"
    Environment = "Development"
  }
}

resource "aws_subnet" "development_private_2" {
  vpc_id                  = aws_vpc.development.id
  cidr_block              = "10.1.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = false

  tags = {
    Name        = "Development-Private-2"
    Environment = "Development"
  }
}

resource "aws_subnet" "shared_private_1" {
  vpc_id                  = aws_vpc.shared_services.id
  cidr_block              = "10.2.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = false

  tags = {
    Name        = "Shared-Private-1"
    Environment = "Shared-Services"
  }
}

resource "aws_subnet" "shared_private_2" {
  vpc_id                  = aws_vpc.shared_services.id
  cidr_block              = "10.2.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = false

  tags = {
    Name        = "Shared-Private-2"
    Environment = "Shared-Services"
  }
}
# ==========================================
# Restrict Default Security Groups
# ==========================================

resource "aws_default_security_group" "production" {
  vpc_id = aws_vpc.production.id

  ingress = []
  egress  = []

  tags = {
    Name        = "Production-Default-SG-Restricted"
    Environment = "Production"
    Project     = "Hub-and-Spoke"
  }
}

resource "aws_default_security_group" "development" {
  vpc_id = aws_vpc.development.id

  ingress = []
  egress  = []

  tags = {
    Name        = "Development-Default-SG-Restricted"
    Environment = "Development"
    Project     = "Hub-and-Spoke"
  }
}

resource "aws_default_security_group" "shared_services" {
  vpc_id = aws_vpc.shared_services.id

  ingress = []
  egress  = []

  tags = {
    Name        = "Shared-Services-Default-SG-Restricted"
    Environment = "Shared-Services"
    Project     = "Hub-and-Spoke"
  }
}
