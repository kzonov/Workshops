resource "aws_security_group" "with-http-and-ssh-allowed" {
  name        = "http-and-ssh-allowed"
  description = "Allow all inbound HTTP and specific SSH traffic"
  vpc_id      = "${data.terraform_remote_state.network.vpc_id}"

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
  from_port   = 8
  to_port     = 0

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
