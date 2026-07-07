terraform {
  backend "s3" {
    bucket = "triphoria-terraform-state"

    key = "dev/triphoria.tfstate"

    region = "ap-south-2"

    encrypt = true
  }
}