
# Production subnet associations

resource "aws_route_table_association" "production_1" {
  subnet_id      = module.network.production_private_subnet_ids[0]
  route_table_id = aws_route_table.production.id
}

resource "aws_route_table_association" "production_2" {
  subnet_id      = module.network.production_private_subnet_ids[1]
  route_table_id = aws_route_table.production.id
}

# Development subnet associations

resource "aws_route_table_association" "development_1" {
  subnet_id      = module.network.development_private_subnet_ids[0]
  route_table_id = aws_route_table.development.id
}

resource "aws_route_table_association" "development_2" {
  subnet_id      = module.network.development_private_subnet_ids[1]
  route_table_id = aws_route_table.development.id
}

# Shared Services subnet associations

resource "aws_route_table_association" "shared_services_1" {
  subnet_id      = module.network.shared_private_subnet_ids[0]
  route_table_id = aws_route_table.shared_services.id
}

resource "aws_route_table_association" "shared_services_2" {
  subnet_id      = module.network.shared_private_subnet_ids[1]
  route_table_id = aws_route_table.shared_services.id
}
