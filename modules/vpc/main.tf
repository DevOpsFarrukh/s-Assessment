#######################################
# Network and Secuirty Group
#######################################
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name      = "${var.environment_name}-vpc"
    DNSLabel  = var.dns_label
  }
}

#######################################
# Internet Gateway
#######################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.environment_name}-igw"
  }
}

#######################################
# Elastic IP for NAT Gateway
#######################################
#######################################
# Elastic IP for NAT Gateway
#######################################
resource "aws_eip" "nat_eip" {
  domain = "vpc"  # Replaces the deprecated 'vpc' argument

  tags = {
    Name = "${var.environment_name}-nat-eip"
  }
}

#######################################
# NAT Gateway
#######################################
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.frontend.id

  tags = {
    Name = "${var.environment_name}-nat"
  }
}


#######################################
# Security Groups
#######################################

## Frontend Security Group
resource "aws_security_group" "frontend_sg" {
  name        = "${var.environment_name}-frontend-sg"
  description = "Security group for frontend"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment_name}-frontend-sg"
  }
}

## App Security Group
resource "aws_security_group" "app_sg" {
  name        = "${var.environment_name}-app-sg"
  description = "Security group for app"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "Allow all traffic from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.this.cidr_block]
  }

  ingress {
    description = "Allow TCP on port 30555 (Load Balancer Healthcheck)"
    from_port   = 30555
    to_port     = 30555
    protocol    = "tcp"
    cidr_blocks = [cidrsubnet(var.vpc_cidr, 8, 2)]
  }

  ingress {
    description = "Allow Kubernetes API Server"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = [cidrsubnet(var.vpc_cidr, 8, 2)]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment_name}-app-sg"
  }
}

## Backend Security Group
resource "aws_security_group" "backend_sg" {
  name        = "${var.environment_name}-backend-sg"
  description = "Security group for backend"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "Allow MySQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment_name}-backend-sg"
  }
}

## Reserved Security Group
resource "aws_security_group" "reserved_sg" {
  name        = "${var.environment_name}-reserved-sg"
  description = "Security group for reserved"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment_name}-reserved-sg"
  }
}

#######################################
# Subnets
#######################################

## Frontend Subnet (Public)
resource "aws_subnet" "frontend" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.frontend_az

  tags = {
    Name     = "${var.environment_name}-frontend"
    DNSLabel = "frontdns"
  }
}

## App Subnet (Private)
resource "aws_subnet" "app" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = var.app_az

  tags = {
    Name     = "${var.environment_name}-app"
    DNSLabel = "appdns"
  }
}

## Backend Subnet (Private)
resource "aws_subnet" "backend" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = false
  availability_zone       = var.backend_az

  tags = {
    Name     = "${var.environment_name}-backend"
    DNSLabel = "backenddns"
  }
}

## Reserved Subnet (Private)
resource "aws_subnet" "reserved" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = false
  availability_zone       = var.reserved_az

  tags = {
    Name     = "${var.environment_name}-reserved"
    DNSLabel = "reserveddns"
  }
}

#######################################
# Route Tables
#######################################

## Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }


  tags = {
    Name = "${var.environment_name}-public-route"
  }
}


## Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${var.environment_name}-private-route"
  }
}

## Route Table Associations

### Public Subnet Association
resource "aws_route_table_association" "frontend_assoc" {
  subnet_id      = aws_subnet.frontend.id
  route_table_id = aws_route_table.public.id
}

### App Subnet Association
resource "aws_route_table_association" "app_assoc" {
  subnet_id      = aws_subnet.app.id
  route_table_id = aws_route_table.private.id
}

### Backend Subnet Association
resource "aws_route_table_association" "backend_assoc" {
  subnet_id      = aws_subnet.backend.id
  route_table_id = aws_route_table.private.id
}

### Reserved Subnet Association
resource "aws_route_table_association" "reserved_assoc" {
  subnet_id      = aws_subnet.reserved.id
  route_table_id = aws_route_table.private.id
}
