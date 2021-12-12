terraform {
  backend "s3" {
    region = "us-east-1"
    bucket = "brezio-infrastructure-prod"
    key    = "apps/cerebrum.tfstate"
  }
}