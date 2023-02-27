#Creating Internet Gateway in AWS VPC.tf
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main.id

  tags = merge({
    Name = "internet gw"
  }, var.project_tags)
}

#Creating NAT in AWS VPC.tf
resource "aws_eip" "nat_gateway" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.subnet[0].id

  tags = merge({
    Name = "NAT gw"
  }, var.project_tags)
}


# Creating Route Tables for Internet gateway
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = merge(var.project_tags, {
    Name = "public-route-table"
  })
}

# Creating Route Associations public subnets
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.subnet[0].id
  route_table_id = aws_route_table.public.id
}


# Creating Route Tables for NAT gateway
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = merge(var.project_tags, {
    Name = "private-route-table"
  })
}


# Creating Route Associations private subnets
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.subnet[1].id
  route_table_id = aws_route_table.private.id
}