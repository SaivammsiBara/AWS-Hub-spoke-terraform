
# ==========================================
# Production SSH Inbound Rule
# ==========================================

resource "aws_vpc_security_group_ingress_rule" "production_ssh" {
  security_group_id            = aws_security_group.production_ec2.id
  referenced_security_group_id = aws_security_group.production_eice.id

  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22

  description = "Allow SSH from Production EICE"
}


# ==========================================
# Development SSH Inbound Rule
# ==========================================

resource "aws_vpc_security_group_ingress_rule" "development_ssh" {
  security_group_id            = aws_security_group.development_ec2.id
  referenced_security_group_id = aws_security_group.development_eice.id

  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22

  description = "Allow SSH from Development EICE"
}


# ==========================================
# Shared Services SSH Inbound Rule
# ==========================================

resource "aws_vpc_security_group_ingress_rule" "shared_services_ssh" {
  security_group_id            = aws_security_group.shared_services_ec2.id
  referenced_security_group_id = aws_security_group.shared_services_eice.id

  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22

  description = "Allow SSH from Shared Services EICE"
}
