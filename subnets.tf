resource "aws_subnet" "subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.cidr_subnets[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch[count.index]
  availability_zone       = "us-east-1a"

  tags = merge(var.project_tags, {
    Name = "subnet-${count.index}"
  })
}

/*
# Creating Public Subnets in VPC.tf
resource "aws_subnet" "public" {
  #count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = merge(var.project_tags, {
    Name = "public-subnet-1"
  })
}

# Creating Private Subnets in VPC.tf
resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1a"

  tags = merge(var.project_tags, {
    Name = "private-subnet-1"
  })
}
*/

