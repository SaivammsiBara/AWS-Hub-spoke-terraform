output "production_vpc_id" {
  value = aws_vpc.production.id
}

output "development_vpc_id" {
  value = aws_vpc.development.id
}

output "shared_services_vpc_id" {
  value = aws_vpc.shared_services.id
}

output "production_private_subnet_ids" {
  value = [
    aws_subnet.production_private_1.id,
    aws_subnet.production_private_2.id
  ]
}

output "development_private_subnet_ids" {
  value = [
    aws_subnet.development_private_1.id,
    aws_subnet.development_private_2.id
  ]
}

output "shared_private_subnet_ids" {
  value = [
    aws_subnet.shared_private_1.id,
    aws_subnet.shared_private_2.id
  ]
}
