terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

variable "access_key" {
    description = "AWS API access key"
    type        = string
    sensitive   = true
}

variable "secret_key" {
    description = "AWS API secret key"
    type        = string
    sensitive   = true
}

variable "ssh_key_path" {
    description = "Path to SSH public key file"
    type        = string
    default     = "ssh_key.pub"
}

variable "region" {
    description = "EC2 region"
    type        = string
    default     = "us-west-2"
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_key_pair" "test_ssh_key" {
  key_name = "test_ssh_key"
  public_key = file(var.ssh_key_path)
}

data "aws_ami" "debian" {
  most_recent = true

  filter {
    name   = "name"
    values = ["debian-10-arm64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["136693071363"]
}

resource "aws_spot_instance_request" "test_inst" {
    count = 100

    ami = data.aws_ami.debian.id
    spot_price    = "0.002"
    instance_type = "t4g.nano"
    wait_for_fulfillment = true

    root_block_device {
        volume_size = 8
        volume_type = "gp3"
    }
    
    key_name = aws_key_pair.test_ssh_key.key_name

    user_data_base64 = base64encode(file("bootstrap.sh"))
}

