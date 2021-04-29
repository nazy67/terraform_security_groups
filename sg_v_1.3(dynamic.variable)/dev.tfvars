# Providers variables
aws_region = "us-east-1"

# Security group variables
web_ingress_ports = [{
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidrs     = ["0.0.0.0/0"]
  },
  {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidrs     = ["0.0.0.0/0"]
  }
 ]
}

# Tags variables
env          = "dev"
project_name = "application"