variable "region" {
  type = "string"
  default = "us-east-1"
}

variable "bucket_name" {
  type = "string"
  default = "mw-terraform-states"
}

variable "lock_name" {
  type = "string"
  default = "terraform-locks"
}

resource "aws_s3_bucket" "terraform-state" {
  bucket = "${var.bucket_name}"
  region = "${var.region}"
  acl = "private"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "terraform-locks" {
  name = "${var.lock_name}"
  hash_key = "LockID"
  read_capacity = 10
  write_capacity = 10

  lifecycle {
    prevent_destroy = true
  }

  attribute {
    name = "LockID",
    type = "S"
  }
}
