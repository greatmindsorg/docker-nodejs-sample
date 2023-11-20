provider "aws" {
  region = "us-east-2"

  default_tags {
    tags = {
      Environment = var.env
      Repository  = "docker-nodejs-sample"
      CreatedWith = "terraform"
      owner       = "gm-reliability"
    }
  }
}