resource "aws_network_interface" "app" {
  subnet_id = "${data.terraform_remote_state.network.subnet_id}"
  security_groups = ["${aws_security_group.with-http-and-ssh-allowed.id}"]
}

resource "aws_eip" "external-address" {
  instance = "${aws_instance.app.id}"
  vpc      = true
}
