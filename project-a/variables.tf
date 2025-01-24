variable "name" {
  description = "the name of your stack, e.g. \"fynd\""
  default     = "glamar"
}


variable "environment" {
  description = "the name of your environment, e.g. \"prod-west\""
}

variable "cidr" {
  description = "the CIDR block to provision for the VPC, if set to something other than the default, both internal_subnets and public_subnets have to be defined as well"
}


variable "public_subnets_block" {
  description = "a list of CIDRs for external subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
  type        = list(any)
}


variable "private_subnets_block" {
  description = "a list of CIDRs for internal subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
  type        = list(any)
}

variable "proxy_only_subnets_block" {
  description = "a list of CIDRs for proxy only subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
  type        = list(any)
}


variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "the AWS region in which resources are created, you must set the availability_zones variable as well if you define this value to something other than the default"
}

variable "service" {
  description = "About service name"
}

variable "service_type" {
  description = "About service type"
}

variable "routing_mode" {
  description = "Route scope Global or local" //REGIONAL or GLOBAL
}

variable "private_ip_google_access" {
  description = "Private conenctivity within VPC"
}
variable "common_labels" {
  type        = map(any)
  description = "labels of resures"

}

variable "gcs_variable" {
  description = "GCS buceket specific variables"
  type        = map(any)
}

variable "location" {
  description = "GCS bucket location"
  default     = "ASIA"
}

variable "kafka_gcs_variable" {
  description = "kafka gcs validate"
}


variable "privatelink" {
  description = "variables for privateLink"
}

variable "pvt_svc_connect_subnets_block" {
  description = "a list of CIDRs for proxy only subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
  type        = list(any)
}