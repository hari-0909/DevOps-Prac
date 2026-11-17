resource "aws_instance" "my_instance"{
  ami = "ami-0ff8a91507f77f867"
  instance_type=var.allowed_vm_types[0]
  region=tolist(var.allowed_region)[0]
  tags=var.tags
  lifecycle {
    create_before_destroy = true
    prevent_destroy = false
  }
}
resource "aws_launch_template" "app_server"{
  name_prefix = "app-server-"
  image_id = "ami-0ff8a91507f77f867"
  instance_type = var.allowed_vm_types[0]
  tag_specifications {
    resource_type = "instance"
    tags=var.tags
  }
}
# Auto scaling group
resource "aws_autoscaling_group" "app_servers" {
  name                      = "app-servers-asg"
  max_size                  = 5
  min_size                  = 1
  desired_capacity          = 2
  health_check_type         = "EC2"
  availability_zones         = ["us-east-1a", "us-east-1b","us-east-1c"]
  launch_template {
    id      = aws_launch_template.app_server.id
    version = "$Latest"
  }
  tag {
    key                 = "Demo"
    value               = "ignore_changes"
    propagate_at_launch = false
  }
  lifecycle {
    ignore_changes = [ 
      desired_capacity,
     ]
  }
}
# lifecycle block with replace_triggered_by
resource "terraform_data" "deployment_version" {
  input = var.version_number[0]
}

resource "aws_instance" "my_instance" {
  ami           = "ami-0ff8a91507f77f867"
  instance_type = var.allowed_vm_types[0]

  lifecycle {
    replace_triggered_by = [
      terraform_data.deployment_version
    ]
  }
}
# precondition and postcondition block
resource "aws_s3_bucket" "compliance_bucket" {
  bucket = "compliance-bucket-${var.environment}-${var.region}"
  tags=var.tags

  lifecycle {
    precondition {
      condition     = contains(keys(var.tags), "Compliance")
      error_message = "ERROR: Bucket must have a 'Compliance' tag to be created."
    }
    postcondition{
      condition = self.tags["Compliance"]=="required"
      error_message="ERROR: Bucket must have compliance tag set to required."
    }
  }
}