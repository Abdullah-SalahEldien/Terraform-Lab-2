provider "aws" {
  region                   = "us-east-1"
  shared_config_files      = ["C:\\Users\\abdo\\.aws\\config"]
  shared_credentials_files = ["C:\\Users\\abdo\\.aws\\credentials"]
  profile                  = "default"
}

# Creating EC2 instances in public subnet
resource "aws_instance" "public_inst_1" {
  ami                         = var.ami
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet[0].id
  vpc_security_group_ids      = [aws_security_group.security_group.id]
  associate_public_ip_address = "true"
  key_name                    = "key-pair"
  user_data = file("install.sh")

  tags = merge(var.project_tags, {
    Name = "public_inst_1"
  })
}

# Creating EC2 instances in private subnet
resource "aws_instance" "private_inst_1" {
  ami                         = var.ami
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet[1].id
  vpc_security_group_ids      = [aws_security_group.security_group.id]
  associate_public_ip_address = "false"
  user_data = file("install.sh")

  tags = merge(var.project_tags, {
    Name = "private_inst_1"
  })
}

output "public_instance_ip_addr" {
  value = aws_instance.public_inst_1.public_ip
}

output "private_instance_ip_addr" {
 value = aws_instance.private_inst_1.private_ip
}

output "elastic_ip_addr" {
  value = aws_eip.nat_gateway.public_ip
}



