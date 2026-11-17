
# Production Transit Gateway Route Table

resource "aws_ec2_transit_gateway_route_table" "production" {
  transit_gateway_id = aws_ec2_transit_gateway.hub.id

  tags = {
    Name    = "Production-TGW-Route-Table"
    Project = "Hub-and-Spoke"
  }
}

# Development Transit Gateway Route Table

resource "aws_ec2_transit_gateway_route_table" "development" {
  transit_gateway_id = aws_ec2_transit_gateway.hub.id

  tags = {
    Name    = "Development-TGW-Route-Table"
    Project = "Hub-and-Spoke"
  }
}

# Shared Services Transit Gateway Route Table

resource "aws_ec2_transit_gateway_route_table" "shared_services" {
  transit_gateway_id = aws_ec2_transit_gateway.hub.id

  tags = {
    Name    = "Shared-Services-TGW-Route-Table"
    Project = "Hub-and-Spoke"
  }
}
