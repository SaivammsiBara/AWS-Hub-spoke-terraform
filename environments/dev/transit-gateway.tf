resource "aws_ec2_transit_gateway" "hub" {
  description = "Hub-and-Spoke Transit Gateway"

  auto_accept_shared_attachments = "disable"

  default_route_table_association = "disable"
  default_route_table_propagation = "disable"

  dns_support = "enable"

  tags = {
    Name    = "Hub-Spoke-TGW"
    Project = "Hub-and-Spoke"
  }
}
