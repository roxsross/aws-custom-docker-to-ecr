provider "aws" {
  region = "us-east-1"
}
data "aws_ami" "amazon" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["137112412989"] 
}
locals {
  instances_count = 1
}

resource "aws_instance" "srv" {
  count                       = local.instances_count
  ami                         = data.aws_ami.amazon.id
  key_name                    = "${var.ec2_key_name}"
  vpc_security_group_ids      = "${var.ec2_security_groups}"
  associate_public_ip_address = true
  source_dest_check           = false
  instance_type               = "${var.ec2_instance_type}"
  subnet_id                   = "${var.ec2_subnet_id}"
  tags                        = local.common_tags
  user_data                   = "${file("data/user_data.tpl")}"
}
