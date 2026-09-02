provider "aws" {
  region = var.region

  default_tags {
    tags = {
      app_id = "APP-12345"
    }
  }

  ignore_tags {
    keys = [
      "domain_join",
      "fqdn",
      "nyl:appid",
    ]

    key_prefixes = [
      "nyl:platform:",
    ]
  }
}


terraform {
  required_version = ">= 1.15"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 6.45"
    }
  }
}
