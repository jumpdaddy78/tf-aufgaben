terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    name = "ha-16-04-vpc"
    cidr = "10.0.0.0/16"
    public_subnets = ["10.0.1.0/24"]
    azs = ["eu-central-1a"]
    map_public_ip_on_launch = true
  
}

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.1"
  name = "docker-ec2"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  subnet_id = module.vpc.public_subnets[0]
  user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install docker -y
                sudo service docker start
                sudo docker run -d -p 80:9898 stefanprodan/podinfo
                EOF

}

resource "aws_security_group_rule" "ssh_in" {
    type = "ingress"
    protocol = "tcp"
    from_port = 22
    to_port = 22
    security_group_id = module.vpc.default_security_group_id
    cidr_blocks = [ "0.0.0.0/0" ]
}
resource "aws_security_group_rule" "http_in" {
    type = "ingress"
    protocol = "tcp"
    from_port = 80  
    to_port = 80
    security_group_id = module.vpc.default_security_group_id
    cidr_blocks = [ "0.0.0.0/0" ]
}
resource "aws_security_group_rule" "all_out" {
    type = "egress"
    protocol = "tcp"
    from_port = 0  
    to_port = 65535
    security_group_id = module.vpc.default_security_group_id
    cidr_blocks = [ "0.0.0.0/0" ]
}

output "ec2-pub-ip" {
    description = "Public IP from EC2-Instance"
    value = module.ec2-instance.public_ip  
}
