module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "test"

  ami                         = "ami-0b5eea76982371e91"
  instance_type               = "t2.micro"
  key_name                    = "awsroxs"
  monitoring                  = true
  associate_public_ip_address = true
  vpc_security_group_ids      = ["sg-04627cd5684f351cc"]
  subnet_id                   = "subnet-049cbf0f8375e5aa0"
  user_data                   = "${file("data/user_data.tpl")}"
  tags                        = local.common_tags
}