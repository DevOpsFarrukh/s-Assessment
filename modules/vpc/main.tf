resource "aws_vpc" "main" {
  cidr_block            = var.vpc_cidr_block
  instance_tenancy      = "default"
  enable_dns_support    = true
  enable_dns_hostnames  = true
  tags                  = local.common_tags
  
  
}

resource "aws_subnet" "public" {
  count                    = length(var.public_subnet_cidr_blocks)
  vpc_id                   = aws_vpc.main.id
  cidr_block               = element(var.public_subnet_cidr_blocks, count.index)
  availability_zone        = element(var.availability_zones, count.index)
  map_public_ip_on_launch  = true
  tags                     = local.common_tags
}

resource "aws_subnet" "private" {
  count                    = length(var.private_subnet_cidr_blocks)
  vpc_id                   = aws_vpc.main.id
  cidr_block               = element(var.private_subnet_cidr_blocks, count.index)
  availability_zone        = element(var.availability_zones, count.index)
  map_public_ip_on_launch  = false
  tags                     = local.common_tags
}

resource "aws_internet_gateway" "gw" {
  vpc_id  = aws_vpc.main.id
  tags    = local.common_tags
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = local.common_tags
}

resource "aws_route_table_association" "public_subnet_associations" {
  count          = length(aws_subnet.public)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_nat_gateway" "nat" {
  # count            = length(aws_subnet.public)
   subnet_id        = aws_subnet.public[0].id
  allocation_id    = aws_eip.nat.id
  
}

resource "aws_eip" "nat" {
  
}

resource "aws_route_table" "private" {
  # count  = length(aws_subnet.private)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    # nat_gateway_id = element(aws_nat_gateway.nat.*.id, count.index)
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = local.common_tags
}

resource "aws_route_table_association" "private_subnet_associations" {
  count          = length(aws_subnet.private)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  # route_table_id = element(aws_route_table.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}