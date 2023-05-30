terraform {
  backend "s3" {
    bucket  = "terraform-larntz"
    key     = "homelab/us-east-2/ssm/terraform.tfstate"
    region  = "us-east-2"
    encrypt = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.4"
}

provider "aws" {
  region  = "us-east-2"
  profile = "homelab"

  default_tags {
    tags = {
      terraform-managed = "true"
    }
  }
}
