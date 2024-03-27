terraform {
  required_version = "~> v1.7.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # For the purposes of this exercise, I'm going to assume local state,
  # but in reality I would use a remote backend with state locks like this:
  # backend "s3" {
  #   bucket         = "state-storage"
  #   key            = "myapp/production/tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "locks-table-name"
  # }
}

provider "aws" {
  region = "us-east-1"
}
