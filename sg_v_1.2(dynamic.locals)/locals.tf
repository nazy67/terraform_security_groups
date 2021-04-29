locals {
  rules = [{
    description = "description 0",
    port        = 22,
    protocol    = "tcp",
    cidr_blocks = ["0.0.0.0/0"],
    }, {
    description = "description 1",
    port        = 80,
    protocol    = "tcp",
    cidr_blocks = ["0.0.0.0/0"],
  }]
}

# comment when you configure your tags in variables.tf
locals {
  tags = {
    Name = "web_sg"
    Environment = "dev"
    Project     = "application"
  }
}