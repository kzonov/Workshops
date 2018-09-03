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
