
resource "aws_route" "production_to_shared" {
  route_table_id         = aws_route_table.production.id
  destination_cidr_block = "10.2.0.0/16"
  transit_gateway_id     = aws_ec2_transit_gateway.hub.id
}



resource "aws_route" "development_to_shared" {
  route_table_id         = aws_route_table.development.id
  destination_cidr_block = "10.2.0.0/16"
  transit_gateway_id     = aws_ec2_transit_gateway.hub.id
}



resource "aws_route" "shared_to_production" {
  route_table_id         = aws_route_table.shared_services.id
  destination_cidr_block = "10.0.0.0/16"
  transit_gateway_id     = aws_ec2_transit_gateway.hub.id
}



resource "aws_route" "shared_to_development" {
  route_table_id         = aws_route_table.shared_services.id
  destination_cidr_block = "10.1.0.0/16"
  transit_gateway_id     = aws_ec2_transit_gateway.hub.id
}
