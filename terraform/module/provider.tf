provider "aws" {
  default_tags {
    tags = {
      Environment  = var.env
      ManagedBy    = "Terraform"
      TerraformSrc = "cerebrum"
      Application  = "cerebrum"
    }
  }
}