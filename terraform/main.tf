#Get our server
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
	profile = "personal"
  region  = "us-west-2"
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = file("~/.ssh/id_rsa.pub")
  }

data "http" "myip"{
    url = "https://ipv4.icanhazip.com"
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all_from_my_ip"
  description = "Allow all inbound traffic (terraform sg)"
  ingress {
    # TCP (change to whatever ports you need)
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }

  egress {
    # Outbound traffic is set to all
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "vsc" {
  ami           = "ami-01bf84e74777aae82"
	instance_type = "t3.micro"
  count            = 1
  associate_public_ip_address = true
	key_name         = "ssh-key"
  vpc_security_group_ids = [aws_security_group.allow_all.id]
}

output "instance_ip" {
 	description = "The public Ip"
 	value = aws_instance.vsc[0].public_ip
 }

#Get our code
module "consul" {
	source = "github.com/Naliana/vscloud"
}
