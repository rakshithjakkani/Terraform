module "website_s3_bucket" {
  source = "./modules/aws-s3-static-website-bucket"

  bucket_name = "rakshith-terraform-local-modules"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
