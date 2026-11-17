variable "environment" {
  default = "dev"
}
# variable "channel_name" {
#   default = "ttwp"
# }
variable "region" {
  type    = string
  default = "us-east-1"
}
variable "instance_count" {
  description = "Number of Ec2 instances to create"
  type        = number
}
variable "monitoring_enabled" {
  description = "Enable monitoring for the instance"
  type        = bool
  default     = true
}
variable "associate_public_ip_address" {
  description = "Associate public ip address with ec2 instance"
  type        = bool
  default     = true
}
variable "cidr_block" {
  description = "CIDR block for VPC"
  type        = list(string)
  default     = ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]
}
variable "allowed_vm_types" {
  description = "List of allowed VM types"
  type        = list(string)
  default     = ["t3.micro", "t2.small", "t2.medium"]
}
variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "TerraformDemo"
  }
}
variable "allowed_region" {
  description = "Lis of allowed aws regions"
  type        = set(string)
  default     = ["us-east-1", "us-east-2", "us-west-1", "us-west-1"]
}
variable "config" {
  type = object({
    region         = string,
    monitoring     = bool,
    instance_count = number
  })
  default = {
    region         = "us-east=1",
    monitoring     = true,
    instance_count = 1
  }
}
variable "bucket_names" {
  description = "List of S3 bucket names"
  type        = list(string)
  default     = ["hari-devops-lab-20261116-01","hari-devops-lab-20261116-02","hari-devops-lab-20261116-03"]
}
variable "bucket_names_set" {
  description = "Set of S3 bucket names"
  type        = set(string)
  default     = ["hari-devops-lab-20261116-001","hari-devops-lab-20261116-002","hari-devops-lab-20261116-003"]
}
variable "version_number" {
  description = "Version number for deployment"
  type        = list(string)
  default     = ["v1","v2","v3"]
}