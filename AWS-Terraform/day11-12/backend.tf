terraform {
  backend "s3" {
    bucket       = "hari-terraform-lab-262995338676-nov12"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = "true"
  }
}