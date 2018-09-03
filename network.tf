# Network part

provider "aws" {
  region = "eu-west-1"
  profile = "sandbox"
}

terraform {
  backend "s3" {
    encrypt = true
    bucket  = "dod-terraform-remote-state-storage-s3-kzonov"
    region  = "eu-west-1"
    profile = "sandbox"
    key     = "kzonov/DOD.tfstate"
  }
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

resource "aws_route_table_association" "dod" {
  subnet_id      = "${aws_subnet.dod-public.id}"
  route_table_id = "${aws_route_table.dod-public.id}"
}

resource "aws_internet_gateway" "dod-public" {
  vpc_id = "${aws_vpc.dod.id}"

  tags {
    Name = "dod-public"
  }
}
