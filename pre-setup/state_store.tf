provider "aws" {
  region = "eu-west-1"
  profile = "sandbox"
}

resource "aws_s3_bucket" "state-storage-s3" {
  bucket = "dod-terraform-remote-state-storage-s3-kzonov"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_dynamodb_table" "dod-terraform-remote-state-locker-network-kzonov" {
  name           = "dod-terraform-remote-state-locker-network-kzonov"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "dod-terraform-remote-state-locker-machine-kzonov" {
  name           = "dod-terraform-remote-state-locker-machine-kzonov"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
