# ====================
# VPC
# ====================
resource "aws_vpc" "test_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "test"
  }
}

# ====================
# Subnet
# ====================

resource "aws_subnet" "test_subnet" {
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "test"
  }
}

# ====================
# Route Table
# ====================
resource "aws_internet_gateway" "test_IGW" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "test"
  }
}

resource "aws_route_table" "test_route_table" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "test"
  }
}

resource "aws_route" "test_route" {
  gateway_id             = aws_internet_gateway.test_IGW.id
  route_table_id         = aws_route_table.test_route_table.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "test_route_association" {
  subnet_id      = aws_subnet.test_subnet.id
  route_table_id = aws_route_table.test_route_table.id
}

