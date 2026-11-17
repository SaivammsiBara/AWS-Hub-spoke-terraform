# ==========================================
# Production EICE Security Group
# ==========================================

resource "aws_security_group" "production_eice" {
  name        = "Production-EICE-SG"
  description = "Security group for Production EC2 Instance Connect Endpoint"
  vpc_id      = module.network.production_vpc_id

  tags = {
    Name    = "Production-EICE-SG"
    Project = "Hub-and-Spoke"
  }
}

resource "aws_vpc_security_group_egress_rule" "production_eice_ssh" {
  security_group_id            = aws_security_group.production_eice.id
  referenced_security_group_id = aws_security_group.production_ec2.id

  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22

  description = "Allow SSH from EICE to Production EC2 instances"
}


# ==========================================
# Development EICE Security Group
# ==========================================

resource "aws_security_group" "development_eice" {
  name        = "Development-EICE-SG"
  description = "Security group for Development EC2 Instance Connect Endpoint"
  vpc_id      = module.network.development_vpc_id

  tags = {
    Name    = "Development-EICE-SG"
    Project = "Hub-and-Spoke"
  }
}

resource "aws_vpc_security_group_egress_rule" "development_eice_ssh" {
  security_group_id            = aws_security_group.development_eice.id
  referenced_security_group_id = aws_security_group.development_ec2.id

  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22

  description = "Allow SSH from EICE to Development EC2 instances"
}


# ==========================================
# Shared Services EICE Security Group
# ==========================================

resource "aws_security_group" "shared_services_eice" {
  name        = "Shared-Services-EICE-SG"
  description = "Security group for Shared Services EC2 Instance Connect Endpoint"
  vpc_id      = module.network.shared_services_vpc_id

  tags = {
    Name    = "Shared-Services-EICE-SG"
    Project = "Hub-and-Spoke"
  }
}

resource "aws_vpc_security_group_egress_rule" "shared_services_eice_ssh" {
  security_group_id            = aws_security_group.shared_services_eice.id
  referenced_security_group_id = aws_security_group.shared_services_ec2.id

  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22

  description = "Allow SSH from EICE to Shared Services EC2 instances"
}
