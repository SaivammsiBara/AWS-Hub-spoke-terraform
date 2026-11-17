
resource "aws_route_table" "production" {
  vpc_id = module.network.production_vpc_id

  tags = {
    Name    = "Production-VPC-Route-Table"
    Project = "Hub-and-Spoke"
  }
}



resource "aws_route_table" "development" {
  vpc_id = module.network.development_vpc_id

  tags = {
    Name    = "Development-VPC-Route-Table"
    Project = "Hub-and-Spoke"
  }
}



resource "aws_route_table" "shared_services" {
  vpc_id = module.network.shared_services_vpc_id

  tags = {
    Name    = "Shared-Services-VPC-Route-Table"
    Project = "Hub-and-Spoke"
  }
}
