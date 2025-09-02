terraform {
  required_version = ">= 1.7.0"

  backend "s3" {
    bucket         = "infra-versioning-state-bucket"
    key            = "infra/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}
