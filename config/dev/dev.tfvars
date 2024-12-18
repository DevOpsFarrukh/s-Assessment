aws_region = "us-east-1"
vpc_cidr_block = "10.0.0.0/16"
cluster_version = ""
environment_name = ""

public_subnet_cidr_blocks  = ["10.0.2.0/24", "10.0.4.0/24", "10.0.6.0/24", "10.0.8.0/24"]
private_subnet_cidr_blocks = ["10.0.1.0/24", "10.0.3.0/24", "10.0.5.0/24", "10.0.7.0/24"]
availability_zones         = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]

ingress_rule_list = [
  {
    cidr_blocks   = ["10.0.0.0/16"]
    description   = "Allow inbound traffic on port 80"
    direction     = "ingress"
    from_port     = 80
    protocol      = "tcp"
    to_port       = 80
    source_security_group_id=null
  },
  
  {
    source_security_group_id = null
    description             = "Allow outbound traffic on port 443"
    direction               = "ingress"
    from_port               = 443
    protocol                = "tcp"
    to_port                 = 443
    cidr_blocks=["10.0.0.0/16"]
  }
]

egress_rule_list = [
  {
    source_security_group_id = null
    cidr_blocks             = ["0.0.0.0/0"]
    description             = "Allow all outbound traffic"
    direction               = "egress"
    from_port               = 0
    protocol                = "all"
    to_port                 = 65535
  }
]

description = "Example Security Group"
identifier  = "farrukh"