data "terraform_remote_state" "blue42_route53" {
  backend = "s3"
  config = {
    bucket = "terraform-larntz"
    key    = "global/route53/blue42/terraform.tfstate"
    region = "us-east-2"
  }
}
