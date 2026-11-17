# ==========================================
# Production EICE Endpoint
# ==========================================

resource "aws_ec2_instance_connect_endpoint" "production" {
  subnet_id = module.network.production_private_subnet_ids[0]

  security_group_ids = [
    aws_security_group.production_eice.id
  ]

  preserve_client_ip = false

  tags = {
    Name    = "Production-EICE-Endpoint"
    Project = "Hub-and-Spoke"
  }
}


# ==========================================
# Development EICE Endpoint
# ==========================================

resource "aws_ec2_instance_connect_endpoint" "development" {
  subnet_id = module.network.development_private_subnet_ids[0]

  security_group_ids = [
    aws_security_group.development_eice.id
  ]

  preserve_client_ip = false

  tags = {
    Name    = "Development-EICE-Endpoint"
    Project = "Hub-and-Spoke"
  }
}


# ==========================================
# Shared Services EICE Endpoint
# ==========================================

resource "aws_ec2_instance_connect_endpoint" "shared_services" {
  subnet_id = module.network.shared_private_subnet_ids[0]

  security_group_ids = [
    aws_security_group.shared_services_eice.id
  ]

  preserve_client_ip = false

  tags = {
    Name    = "Shared-Services-EICE-Endpoint"
    Project = "Hub-and-Spoke"
  }
}
