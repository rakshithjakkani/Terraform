terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key     = "project-b/terraform.tfstate"
    region  = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt = true
  }
}