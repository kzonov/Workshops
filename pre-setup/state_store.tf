resource "aws_s3_bucket" "state-storage-s3" {
  bucket = "dod-terraform-remote-state-storage-s3-kzonov"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_dynamodb_table" "dod-terraform-remote-state-lock-kzonov" {
  name           = "dod-terraform-remote-state-lock-kzonov"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
