
#######################################
# Outputs
#######################################
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.nat.id
}

output "frontend_sg_id" {
  description = "Security Group ID for Frontend"
  value       = aws_security_group.frontend_sg.id
}

output "app_sg_id" {
  description = "Security Group ID for App"
  value       = aws_security_group.app_sg.id
}

output "backend_sg_id" {
  description = "Security Group ID for Backend"
  value       = aws_security_group.backend_sg.id
}

output "reserved_sg_id" {
  description = "Security Group ID for Reserved"
  value       = aws_security_group.reserved_sg.id
}

output "frontend_subnet_id" {
  description = "The ID of the Frontend (Public) Subnet"
  value       = aws_subnet.frontend.id
}

output "app_subnet_id" {
  description = "The ID of the App (Private) Subnet"
  value       = aws_subnet.app.id
}


output "backend_subnet_id" {
  description = "The ID of the Backend (Private) Subnet"
  value       = aws_subnet.backend.id
}


output "reserved_subnet_id" {
  description = "The ID of the Reserved (Private) Subnet"
  value       = aws_subnet.reserved.id
}

output "public_route_table_id" {
  description = "The ID of the Public Route Table"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "The ID of the Private Route Table"
  value       = aws_route_table.private.id
}
