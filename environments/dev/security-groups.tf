
# ==========================================
# PRODUCTION SECURITY GROUP
# ==========================================

resource "aws_security_group" "production_ec2" {
  name        = "Production-EC2-SG"
  description = "Security group for Production EC2 instances"
  vpc_id      = module.network.production_vpc_id

  tags = {
    Name    = "Production-EC2-SG"
    Project = "Hub-and-Spoke"
  }
}

# Allow ICMP within Production VPC
resource "aws_vpc_security_group_ingress_rule" "production_self_icmp" {
  security_group_id = aws_security_group.production_ec2.id

  cidr_ipv4   = "10.0.0.0/16"
  ip_protocol = "icmp"
  from_port   = -1
  to_port     = -1

  description = "Allow all ICMP traffic within Production VPC"
}

# Allow ICMP from Shared Services
resource "aws_vpc_security_group_ingress_rule" "production_icmp" {
  security_group_id = aws_security_group.production_ec2.id

  cidr_ipv4   = "10.2.0.0/16"
  ip_protocol = "icmp"
  from_port   = -1
  to_port     = -1

  description = "Allow all ICMP traffic from Shared Services"
}

# Allow all outbound traffic
resource "aws_vpc_security_group_egress_rule" "production_all" {
  security_group_id = aws_security_group.production_ec2.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"

  description = "Allow all outbound traffic"
}


# ==========================================
# DEVELOPMENT SECURITY GROUP
# ==========================================

resource "aws_security_group" "development_ec2" {
  name        = "Development-EC2-SG"
  description = "Security group for Development EC2 instances"
  vpc_id      = module.network.development_vpc_id

  tags = {
    Name    = "Development-EC2-SG"
    Project = "Hub-and-Spoke"
  }
}

# Allow ICMP within Development VPC
resource "aws_vpc_security_group_ingress_rule" "development_self_icmp" {
  security_group_id = aws_security_group.development_ec2.id

  cidr_ipv4   = "10.1.0.0/16"
  ip_protocol = "icmp"
  from_port   = -1
  to_port     = -1

  description = "Allow all ICMP traffic within Development VPC"
}

# Allow ICMP from Shared Services
resource "aws_vpc_security_group_ingress_rule" "development_icmp" {
  security_group_id = aws_security_group.development_ec2.id

  cidr_ipv4   = "10.2.0.0/16"
  ip_protocol = "icmp"
  from_port   = -1
  to_port     = -1

  description = "Allow all ICMP traffic from Shared Services"
}

# Allow all outbound traffic
resource "aws_vpc_security_group_egress_rule" "development_all" {
  security_group_id = aws_security_group.development_ec2.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"

  description = "Allow all outbound traffic"
}


# ==========================================
# SHARED SERVICES SECURITY GROUP
# ==========================================

resource "aws_security_group" "shared_services_ec2" {
  name        = "Shared-Services-EC2-SG"
  description = "Security group for Shared Services EC2 instances"
  vpc_id      = module.network.shared_services_vpc_id

  tags = {
    Name    = "Shared-Services-EC2-SG"
    Project = "Hub-and-Spoke"
  }
}

# Allow ICMP within Shared Services VPC
resource "aws_vpc_security_group_ingress_rule" "shared_self_icmp" {
  security_group_id = aws_security_group.shared_services_ec2.id

  cidr_ipv4   = "10.2.0.0/16"
  ip_protocol = "icmp"
  from_port   = -1
  to_port     = -1

  description = "Allow all ICMP traffic within Shared Services VPC"
}

# Allow ICMP from Production
resource "aws_vpc_security_group_ingress_rule" "shared_from_production" {
  security_group_id = aws_security_group.shared_services_ec2.id

  cidr_ipv4   = "10.0.0.0/16"
  ip_protocol = "icmp"
  from_port   = -1
  to_port     = -1

  description = "Allow all ICMP traffic from Production"
}

# Allow ICMP from Development
resource "aws_vpc_security_group_ingress_rule" "shared_from_development" {
  security_group_id = aws_security_group.shared_services_ec2.id

  cidr_ipv4   = "10.1.0.0/16"
  ip_protocol = "icmp"
  from_port   = -1
  to_port     = -1

  description = "Allow all ICMP traffic from Development"
}

# Allow all outbound traffic
resource "aws_vpc_security_group_egress_rule" "shared_all" {
  security_group_id = aws_security_group.shared_services_ec2.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"

  description = "Allow all outbound traffic"
}
