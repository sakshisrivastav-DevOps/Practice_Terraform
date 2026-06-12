terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "6.38.0"
        }
    }
}

  backend "S3" {
    bucket = "state_locking_concept_bucket"
    dynamodb = "remote-table"
    statefile = "terraform.tf"
    region = "us-west-2"  #bucket region"
}