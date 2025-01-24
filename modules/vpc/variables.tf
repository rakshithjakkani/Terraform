variable "cidr" {
  description = "The CIDR block for the VPC."
}

variable "public_subnets_block_1" {
  description = "List of public subnets"
  type        = "list"
}

variable "public_subnets_block_2" {
  description = "List of public subnets"
  type        = "list"
}

variable "environment" {
  description = "Environment tag, e.g prod"
}

variable "name" {
  description = "Name tag, e.g fynd-stack"
}

variable "private_subnet_block_1" {
  description = "List of private subnets"
  type        = "list"
}

variable "nat_az_and_subnet_name" {}

variable "tags" {
  description = "common tags"
  type = list()
}