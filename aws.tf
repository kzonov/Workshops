# #
# # Will be used once I make state to be remotely stored
# #
# # terraform {
# #   backend "s3" {
# #     encrypt = true
# #     bucket  = "terraform-remote-state-storage-s3-kzonov"
# #     region  = "eu-west-1"
# #     key     = "kzonov/DOD.tfstate"
# #   }
# # }
# #
# # resource "aws_s3_bucket" "terraform-state-storage-s3" {
# #   bucket = "dod-terraform-remote-state-storage-s3-kzonov"
# #
# #   versioning {
# #     enabled = true
# #   }
# #
# #   lifecycle {
# #     prevent_destroy = true
# #   }
# # }
#
# provider "aws" {
#   region = "eu-west-1"
# }
#
# resource "aws_security_group" "with-http-and-ssh-allowed" {
#   name        = "allow-http"
#   description = "Allow all inbound http and SSH traffic"
#   vpc_id      = "${aws_vpc.web.id}"
#
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
#
# resource "aws_security_group_rule" "allow-http" {
#   type        = "ingress"
#   from_port   = "80"
#   to_port     = "80"
#   protocol    = "tcp"
#   cidr_blocks = ["0.0.0.0/0"]
#
#   security_group_id = "${aws_security_group.with-http-and-ssh-allowed.id}"
# }
#
# resource "aws_security_group_rule" "allow-ssh" {
#   type        = "ingress"
#   from_port   = "22"
#   to_port     = "22"
#   protocol    = "tcp"
#   cidr_blocks = ["0.0.0.0/0"]
#
#   security_group_id = "${aws_security_group.with-http-and-ssh-allowed.id}"
# }
#
# resource "aws_network_interface" "app" {
#   subnet_id = "${aws_subnet.web.id}"
#   # private_ips = ["172.35.10.100"]
# }
#
# resource "aws_instance" "web" {
#   ami           = "${data.aws_ami.ubuntu.id}"
#   instance_type = "t2.micro"
#
#   # vpc_security_group_ids = ["${aws_security_group.with-http-and-ssh-allowed.id}"]
#
#     network_interface {
#      network_interface_id = "${aws_network_interface.app.id}"
#      device_index = 0
#   }
# }
#
# data "aws_ami" "ubuntu" {
#   most_recent = true
#
#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
#   }
#
#   owners = ["099720109477"] # Canonical Ltd., the company behind Ubuntu
# }
