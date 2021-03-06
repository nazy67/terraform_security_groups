 resource "aws_security_group" "web_sg" {
  name        = "${var.env}_web_sg"
  description = "Allow TLS inbound traffic"

  ingress {
    description = "http_ingress"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = var.ingress_protocol
    cidr_blocks = [var.cidr_block]
  }

  ingress {
    description = "ssh_ingress"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = var.ingress_protocol
    cidr_blocks = [var.cidr_block]
  }

  egress {
    from_port   = var.egress_port
    to_port     = var.egress_port
    protocol    = var.egress_protocol
    cidr_blocks = [var.cidr_block]
  }

  tags = {
    Name        = "${var.env}_web_sg"
    Environment = var.env
    Project     = var.project_name
  }
}