locals {
  eks_addons = {
    "vpc-cni"      = "v1.19.0-eksbuild.1"
    "coredns"      = "v1.11.4-eksbuild.2"
    "kube-proxy"   = "v1.31.2-eksbuild.3"
    "metrics-server" = "v0.7.2-eksbuild.1"
  }
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where the EKS cluster will be deployed"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the EKS worker nodes"
  type        = list(string)
}

variable "eks_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.27"
}

variable "node_group_instance_type" {
  description = "Instance type for the EKS worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "node_group_desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "node_group_max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 3
}

variable "node_group_min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}