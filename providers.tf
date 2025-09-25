terraform {
  required_version = ">=1.7.0, <2.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"

    }
  }
}

provider "aws" {
  region = "us-east-1"

}

provider "aws" {
  region = "us-west-2"
  alias  = "us-west"
}

