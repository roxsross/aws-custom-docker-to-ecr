locals {
  common_tags = {
    Name            = "ec2-${var.app_id}-${var.app_env}"
    environment     = "${var.app_env}"
    product_name    = "${var.app_id}-${var.app_env}"
    deployment_type = "terraform"
    info_appid      = "Demo"   
  }
}

variable "app_env" {}
variable "app_id" {}
variable aws_region {}
variable aws_account_id {}
variable ec2_instance_type {}
variable ec2_subnet_id {}
variable ec2_key_name {}
variable ec2_security_groups { type = list}
variable ec2_public_ip {}
variable ec2_instance_count {}
variable ec2_root_volume_size {}
variable ec2_root_volume_type {}
variable "ebs_block_device" {
  type        = list(map(string))
  default     = []
}
