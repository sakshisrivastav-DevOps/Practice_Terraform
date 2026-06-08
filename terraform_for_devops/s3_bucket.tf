provider "aws" {
    region = "us-west-2"
}

resource "aws_s3_bucket" "my_bucket" {

  bucket = "first_s3_bucket"  #this should be unique

}
  