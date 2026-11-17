resource "aws_ec2_transit_gateway_vpc_attachment" "production" {
  transit_gateway_id = aws_ec2_transit_gateway.hub.id
  vpc_id             = module.network.production_vpc_id

  subnet_ids = module.network.production_private_subnet_ids

  dns_support = "enable"

  tags = {
    Name        = "Production-TGW-Attachment"
    Environment = "Production"
  }
}
resource "aws_ec2_transit_gateway_vpc_attachment" "development" {
  transit_gateway_id = aws_ec2_transit_gateway.hub.id
  vpc_id             = module.network.development_vpc_id

  subnet_ids = module.network.development_private_subnet_ids

  dns_support = "enable"

  tags = {
    Name        = "Development-TGW-Attachment"
    Environment = "Development"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "shared_services" {
  transit_gateway_id = aws_ec2_transit_gateway.hub.id
  vpc_id             = module.network.shared_services_vpc_id

  subnet_ids = module.network.shared_private_subnet_ids

  dns_support = "enable"

  tags = {
    Name        = "Shared-Services-TGW-Attachment"
    Environment = "Shared-Services"
  }
}
