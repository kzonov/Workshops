output "vpc_id" {
  value = "${aws_vpc.dod.id}"
}

output "subnet_id" {
  value = "${aws_subnet.dod-public.id}"
}
