## Terraform security groups

This repository has multiple versions of ```Security group``` templates which will provision  on AWS provider.

1. Version 1.0 Hard coded Security group.

 This version of ```Security group``` is the hard coded configuration file, it's not a best practice to configure  your security group this way. But for the learning purposes it's good start as it's very simple and easy to understand. Not using variables makes your template ```not reusable```, and each time when you change a line of code, you need to go back to your code and look for it (sometimes it's lots of lines of code). Most of the time there's a big chance of unintetional changes. As we use ```IaaC``` such as ```Terraform```, one of the main purposes of it is to automate provisioning of your resources and avoid human errors. That's why try to make our code reusable, and when we write our code once we don't touch it, for that we use ```variables```.

2.  Version 1.1 Security group with variables file.

This security group template is the most simplified version of security group resource block using variables in my example with ```variables.tf``` and ```dev.tfvars``` files.

Variables  makes your template reusable as we mentioned above, where all the given variables can be changed depending your needs. The changes has to be made in varibles.tf for defining variables and the values for defined variables we give in dev.tfvars file.  Usually ```dev.tfvars``` is inside of the ```tfvars``` folder, it's best practice for separating environments, when we do ```tfvars``` folder it would look like this:

<img src="image/tfvars.png" alt="aws" width="200" height="50">

3. Version 1.2 Security group with dynamic block and locals file.

In this version of Security group we introduced ```dynamic block```  and ```locals```, which contains all the values of attributes needed for creation security group with two inbound rules (22 and 80). ```for_each``` meta-argument ```itirate``` over the given list of attributes and values and creates security group rules. Values are defined in ```locals.tf``` file makes this version of security group different, than the previous one. But we kept the tag variables definition in ```variables.tf``` just commented it out and values for it in ```dev.tfvars```too. You can do that, or comment tag values in ```locals.tf``` file and uncomment tags in variables.tf and dev.tfvars, it's up to your preferences. Configuring security group this way made our security group reusable, the attributes for the rules can be changed in ```locals.tf``` and for tags in ```variables.tf```, ```dev.tfvars``` or in ```locals.tf```.

tags in ```locals.tf``` 
```
locals {         # comment when you configure your tags in variables.tf
  tags = {
    Name = "web_sg"
    Environment = "dev"
    Project     = "application"
  }
}
```

tags part in ```security_group.tf```
```
# comment this when you configure your tags in variables.tf
  tags = local.tags

# uncomment when you want to configure tags in variables.tf
  # tags = {
  #   Name        = "${var.env}_web_sg"
  #   Environment = var.env
  #   Project     = var.project_name
  # }
```

tags definiton in ```variables.tf```
```
# Tags variables

variable "env" {         # the reason why this part was left uncommented, because we used env variables for naming the resource block
  type        = string
  description = "name of the environment"
}

# variable "project_name" {     # uncomment when you define your tags in variables.tf
#   type        = string
#   description = "name of the project"
# }
```

```dev.tfvars``` file
```
# Tags variables

env = "dev"
# project_name = "application"  # uncomment when you define your tags in variables.tf
```

4. Version 1.3 Security group with dynamic block with variables file.

This security group reusable and contains ```dynamic block``` and ```variables.tf``` with definitions for each rule and ```dev.tfvars``` with the values for the given attributes. Meta-argument "for_each" was used same as in the previous version, but this time we don't have locals.```for_each``` is looping and getting values for each security roup rule, and creates 2 inbound rules 22 and 80. I commented out this part in the variables.tf and passed the values in dev.tfvars file.
```
# Security group variables

variable "web_ingress_ports" {
  type = list  # or list(any)   
#   default = [{
#     from_port = 22
#     to_port   = 22
#     protocol  = "tcp"
#     cidrs     = ["0.0.0.0/0"]
#   },
#   {
#     from_port = 80
#     to_port   = 80
#     protocol  = "tcp"
#     cidrs     = ["0.0.0.0/0"]
#   }
#  ]
}

```

You can either keep as a default value security group values in ```variables.tf``` or move it to ```dev.tfvars``` under ```web_ingress_ports```, both will work.
```
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
```