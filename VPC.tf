# Creating VPC.tf,name, CIDR and Tags
resource "aws_vpc" "main" {
  cidr_block                     = var.cidr_vpc
  instance_tenancy               = "default"
  enable_dns_support             = "true"
  enable_dns_hostnames           = "true"


  tags = merge(var.project_tags, {
    Name = "vpc"
  })
}
