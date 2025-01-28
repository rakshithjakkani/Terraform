variable "vpc_id" {
  description = "VPC ID where resources will be created"
  type        = string
}

variable "sg_name" {
  description = "Name of the security group"
  type        = string
  default     = "bastion-sg"
}

variable "ssh_allowed_ips" {
  description = "List of IP addresses allowed to SSH into Bastion Host"
  type        = list(string)
}

variable "ami" {
  description = "AMI ID for the Bastion Host"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type for the Bastion Host"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID for the Bastion Host"
  type        = string
}

variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
}

variable "public_key" {
  description = "The public SSH key to associate with the EC2 instance"
  type        = string
}
