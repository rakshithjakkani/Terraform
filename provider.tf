provider "aws" {
  region = "us-west-1"
}

provider "aws" {
  alias  = "project_b"
  region = "us-east-1"
}
