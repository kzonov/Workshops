# Machine part

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

resource "aws_network_interface" "app" {
  subnet_id = "${aws_subnet.dod-public.id}"
  security_groups = ["${aws_security_group.with-http-and-ssh-allowed.id}"]
}

resource "aws_eip" "external-address" {
  instance = "${aws_instance.app.id}"
  vpc      = true
}

resource "aws_security_group" "with-http-and-ssh-allowed" {
  name        = "http-and-ssh-allowed"
  description = "Allow all inbound HTTP and specific SSH traffic"
  vpc_id      = "${aws_vpc.dod.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "allow-ping" {
  type        = "ingress"
  protocol    = "icmp"
  cidr_blocks = ["0.0.0.0/0"]
  from_port = 8
  to_port = 0

  security_group_id = "${aws_security_group.with-http-and-ssh-allowed.id}"
}

resource "aws_security_group_rule" "allow-http" {
  type        = "ingress"
  from_port   = "80"
  to_port     = "80"
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.with-http-and-ssh-allowed.id}"
}

resource "aws_security_group_rule" "allow-ssh" {
  type        = "ingress"
  from_port   = "22"
  to_port     = "22"
  protocol    = "tcp"
  cidr_blocks = ["95.91.245.0/24"]

  security_group_id = "${aws_security_group.with-http-and-ssh-allowed.id}"
}

output "ip" {
  value = "${aws_eip.external-address.public_ip}"
}
