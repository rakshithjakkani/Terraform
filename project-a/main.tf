provider "aws" {
  region  = var.region
}

terraform {
  required_version = "0.14.0"
  required_providers {
    google = {
      source  = "hashicorp/aws"
      version = "4.34.0"
    }
  }
  backend "gcs" {
    bucket = "konnect-prod-infrastructure-terraform-state"
    prefix = "konnect/base-infra/terraform.tfstate"
  }
}