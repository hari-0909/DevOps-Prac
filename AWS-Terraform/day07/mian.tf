
resource "aws_instance" "example" {
  count=var.instance_count
  ami           = "resolve:ssm:/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
  instance_type = var.allowed_vm_types[1]
  # region        = tolist(var.allowed_region)[0]
  region = var.config.region
  monitoring = var.monitoring_enabled
  associate_public_ip_address = var.associate_public_ip_address
  tags = {
    Name        = "${var.environment}-EC2-Instance"
    Environment = var.environment
    created_by  = "terraform"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
   
  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = var.cidr_block[0]
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
