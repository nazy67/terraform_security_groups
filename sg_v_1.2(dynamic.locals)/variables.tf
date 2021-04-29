# Providers variables

variable "aws_region" {
  type        = string
  description = "The region Terraform deploys your infra"
}

# Security group variables

# Tags variables

variable "env" {
  type        = string
  description = "name of the environment"
}

# uncomment when you configure your tags in variables.tf
# variable "project_name" { 
#   type        = string
#   description = "name of the project"
# }