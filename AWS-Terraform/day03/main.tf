terraform {
  required_providers {
    aws={
        source = "hashicorp/aws"
        version="~>6.0"
    }
  }
}
# configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
#create a VPC
resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
}
#create a S3 bucket
resource "aws_s3_bucket" "first_bucket" {
  bucket = "hari-terraform-lab-262995338676-nov12"
  tags={
    Name = "My first bucket"
    Environment = "Dev"
  }
}