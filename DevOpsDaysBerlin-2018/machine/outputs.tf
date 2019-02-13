output "ip" {
  value = "${aws_eip.external-address.public_ip}"
}
