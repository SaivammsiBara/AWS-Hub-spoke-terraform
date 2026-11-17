
# Production -> Shared Services

resource "aws_ec2_transit_gateway_route" "production_to_shared" {
  destination_cidr_block         = "10.2.0.0/16"
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.production.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.shared_services.id
}

# Development -> Shared Services

resource "aws_ec2_transit_gateway_route" "development_to_shared" {
  destination_cidr_block         = "10.2.0.0/16"
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.development.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.shared_services.id
}

# Shared Services -> Production

resource "aws_ec2_transit_gateway_route" "shared_to_production" {
  destination_cidr_block         = "10.0.0.0/16"
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.shared_services.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.production.id
}

# Shared Services -> Development

resource "aws_ec2_transit_gateway_route" "shared_to_development" {
  destination_cidr_block         = "10.1.0.0/16"
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.shared_services.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.development.id
}
