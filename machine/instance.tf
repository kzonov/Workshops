# TODO:
# elb
# autoscaling_group with elb health_check

resource "aws_instance" "app" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  key_name = "kzonov-babbel"

  network_interface {
    network_interface_id = "${aws_network_interface.app.id}"
    device_index = 0
  }

  tags {
    Name = "dod-app"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical Ltd., the company behind Ubuntu
}
