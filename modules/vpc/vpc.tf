resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc-cidr-block
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"

  tags = {
    Name = var.vpc-name
  }
}

# InternetGateway creation and Attachment

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.vpc-name}-IGW"
  }
}

# NAT gateway creation

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public-subnet[0].id
  tags = {
    Name = "${var.vpc-name}-NAT"
  }
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_eip" "eip" {
  vpc = true
}

# Route table creation and Attachment

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.vpc-name}-public-rtb"
  }
}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${var.vpc-name}-private-rtb"
  }
}

resource "aws_route_table_association" "public-rtb-association" {
  count          = length(var.public-subnets-data)
  subnet_id      = aws_subnet.public-subnet[count.index].id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "private-rtb-association" {
  count          = length(var.private-subnets-data)
  subnet_id      = aws_subnet.private-subnet[count.index].id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_subnet" "public-subnet" {
  count                   = length(var.public-subnets-data)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public-subnets-data[count.index].ipsec
  availability_zone       = var.public-subnets-data[count.index].availability_zone
  map_public_ip_on_launch = "true"
  tags = {
    Name = var.public-subnets-data[count.index].name
  }
}

resource "aws_subnet" "private-subnet" {
  count             = length(var.private-subnets-data)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private-subnets-data[count.index].ipsec
  availability_zone = var.private-subnets-data[count.index].availability_zone
  tags = {
    Name = var.private-subnets-data[count.index].name
  }
}

resource "aws_security_group" "public-security" {
  name        = "public"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private-security" {
  name        = "private"
  description = "Allow ssh port and postgres port using dynamically"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


