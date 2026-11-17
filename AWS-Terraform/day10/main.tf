resource "aws_instance" "example" {
  ami           = "ami-0ff8a91507f77f867"
  count=var.instance_count
#   instance_type = "t3.micro"
    instance_type=var.environment=="dev" ? "t3.micro" : "t2.micro" 

  tags = var.tags
}
# resource "aws_security_group" "ingress_rule" {
#   name="sg"
#   ingress {
#     from_port=80
#     to_port=80
#     cidr_blocks=["0.0.0.0/0"]
#     protocol="http"
#   }
#   egress=[]
# }
resource "aws_security_group" "ingress_rule"{
    name="sg"
    dynamic "ingress"{
        for_each=var.ingress_rules
        content{
          from_port = ingress.value.from_port
          to_port=ingress.value.to_port
          protocol = ingress.value.protocol
          cidr_blocks = ingress.value.cidr_block
        }
    }
    egress=[]
}
# splat expressions(to extract same attributes from multiple elements of a list or collection in a concise way)
locals{
    all_instance_ids=aws_instance.example[*].id
}
output "instances"{
    value=local.all_instance_ids
}