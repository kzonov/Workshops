# Network part

provider "aws" {
  region = "eu-west-1"
  profile = "sandbox"
}

resource "aws_vpc" "dod" {
  cidr_block = "172.35.0.0/16"

  tags = {
    Name = "dod-public"
  }
}

resource "aws_subnet" "dod-public" {
  vpc_id     = "${aws_vpc.dod.id}"
  cidr_block = "172.35.1.0/24"
  availability_zone = "eu-west-1a"

  tags {
    Name = "dod-public"
  }
}

resource "aws_route_table" "dod-public" {
  vpc_id = "${aws_vpc.dod.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.dod-public.id}"
  }

  tags {
    Name = "dod-public"
  }
}

resource "aws_internet_gateway" "dod-public" {
  vpc_id = "${aws_vpc.dod.id}"

  tags {
    Name = "dod-public"
  }
}


# Machine part

# ec2
# eni
# elastic_ip
# sg
# sg rules

resource "aws_instance" "app" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"

  # vpc_security_group_ids = ["${aws_security_group.with-http-and-ssh-allowed.id}"]

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
  # private_ips = ["172.35.10.100"]
}

resource "aws_eip" "external-address" {
  instance = "${aws_instance.app.id}"
  vpc      = true
}

output "ip" {
  value = "${aws_eip.external-address.public_ip}"
}
