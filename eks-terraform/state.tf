terraform {
  backend "s3" {
    bucket = "eks-atlantis-bucket"
    region = "eu-west-1"
    key    = "terraform.tfstate"
  }
}
