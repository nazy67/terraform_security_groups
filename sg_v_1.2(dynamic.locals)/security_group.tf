resource "aws_security_group" "web_sg" {
  name        = "${var.env}_web_sg"
  description = "allow inbound/outbound traffic"

  dynamic "ingress" {
    for_each = local.rules
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
# comment this when you configure your tags in variables.tf
  tags = local.tags

# uncomment when you want to configure tags in variables.tf
  # tags = {
  #   Name        = "${var.env}_web_sg"
  #   Environment = var.env
  #   Project     = var.project_name
  # }
}