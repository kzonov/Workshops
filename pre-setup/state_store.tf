provider "aws" {
  region = "eu-west-1"
  profile = "sandbox"
}

resource "aws_s3_bucket" "terraform-state-storage-s3" {
  bucket = "dod-terraform-remote-state-storage-s3-kzonov"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}
