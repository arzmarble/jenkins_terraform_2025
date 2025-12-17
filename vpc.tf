# VPC Create
resource "aws_vpc" "GAJ" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "Until-Get-A-JOB-vpc"
  }
}

# Public 1
resource "aws_subnet" "pub-1" {
  vpc_id                  = aws_vpc.GAJ.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.AZ_1
  tags = {
    Name = "GAJ-pub-1"
  }
}

# Private 1
resource "aws_subnet" "priv-1" {
  vpc_id                  = aws_vpc.GAJ.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.AZ_1
  tags = {
    Name = "GAJ-priv-1"
  }
}

# IGW
resource "aws_internet_gateway" "IGW-UAJ" {
  vpc_id = aws_vpc.GAJ.id
  tags = {
    Name = "GAJ-IGW"
  }
  
}

# Route Traffic IGW
resource "aws_route_table" "GAJ-IGW-Public" {
  vpc_id = aws_vpc.GAJ.id
  tags =  {
    Name = "IGW-Public"
  }
}


# Route
resource "aws_route" "UAJ-Route" {
  route_table_id = aws_route_table.GAJ-IGW-Public.id
  gateway_id = aws_internet_gateway.IGW-UAJ.id
  destination_cidr_block = "0.0.0.0/0"
}

# Route with Public
resource "aws_route_table_association" "IGW-Public-1" {
  subnet_id = aws_subnet.pub-1.id
  route_table_id = aws_route_table.GAJ-IGW-Public.id
}

