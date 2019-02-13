resource "aws_vpc" "dod" {
  cidr_block = "172.35.0.0/16"

  tags = {
    Name = "dod-public"
  }
}

resource "aws_subnet" "dod-public" {
  vpc_id            = "${aws_vpc.dod.id}"
  cidr_block        = "172.35.1.0/24"
  availability_zone = "eu-west-1a"

  tags {
    Name = "dod-public"
  }
}
