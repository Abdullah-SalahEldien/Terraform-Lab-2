variable "aws_region" {
  description = "Region for the VPC"
  default = "us-east-1"
}

variable "cidr_vpc" {
  description = "CIDR for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cidr_subnets" {
  description = "CIDR for the subnets"
  type    = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "map_public_ip_on_launch" {
  description = "Should be false if you do not want to auto-assign public IP on launch"
  type        = list(bool)
  default     = [true, false]
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "project_tags" {
  description = "Tags used for the project"
  type        = map(string)
  default = {
    project = "ITI-Aswan"
  }
}

variable "ami" {
  description = "AMI for EC2"
  default = "ami-0dfcb1ef8550277af"
}

variable "key_path" {
  description = "SSH Public Key path"
  default = "/home/core/.ssh/id_rsa.pub"
}