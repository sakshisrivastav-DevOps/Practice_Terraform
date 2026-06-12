#S3

resource "aws_s3_bucket" "testbucket" {
  bucket = "state_locking_concept_bucket"

  tags = {
    Name        = "state_locking_concept_bucket"
  }
}

#Dynamodb

resource "aws_dynamodb_table" "remote-dynamodb-table" {
  name             = "remote-table"
  hash_key         = "LockID"
  billing_mode     = "PAY_PER_REQUEST"
  
  attribute {
    name = "LockID"
    type = "S"
  }
}