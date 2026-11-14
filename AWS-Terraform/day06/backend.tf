terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }

  backend "s3" {
    bucket         = "hari-terraform-lab-262995338676-nov12"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    use_lockfile = "true"
    encrypt        = true
  }
}