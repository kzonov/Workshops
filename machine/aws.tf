provider "aws" {
  region  = "eu-west-1"
  profile = "sandbox"
}

terraform {
  backend "s3" {
    encrypt = true
    bucket  = "dod-terraform-remote-state-storage-s3-kzonov"
    region  = "eu-west-1"
    profile = "sandbox"
    key     = "kzonov/machine.tfstate"

    dynamodb_table = "dod-terraform-remote-state-lock-kzonov"
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"

  config {
    bucket  = "dod-terraform-remote-state-storage-s3-kzonov"
    region  = "eu-west-1"
    profile = "sandbox"
    key     = "kzonov/network.tfstate"
  }
}
