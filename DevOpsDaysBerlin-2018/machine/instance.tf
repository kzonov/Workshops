resource "aws_instance" "app" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  key_name      = "kzonov-babbel"

  network_interface {
    network_interface_id = "${aws_network_interface.app.id}"
    device_index         = 0
  }

  tags {
    Name = "dod-app"
  }
}
