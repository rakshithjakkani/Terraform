variable "vpc_name" {
  description = "name of the vpc"
  type = string
}
variable "vpc_cidr" {
  description = "value"
  type = string
}
variable "project_name" {
  description = "name of the project"
  type = string
}
variable "public_subnet_cidrs" {
  description = "value"
  type = list(string)
}
variable "private_subnet_cidrs" {
  description = "value"
  type = list(string)
}
variable "availability_zones" {
  description = "value"
  type = list(string)
}

###########################################
#-------------EKS variables---------------#
###########################################

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

