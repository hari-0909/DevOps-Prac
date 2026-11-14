terraform {
  required_providers {
    aws={
      source="hashicorp/aws"
      version="~>6.0"
    }
  }
}
# configure the AWS Provider
provider "aws"{
    region = "us-east-1"
}
# create a VPC
resource "aws_vpc" "my_vpc"{
    cidr_block = "10.0.0.0/16"
}