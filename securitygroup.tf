resource "aws_security_group" "cje_instance_security_group" {
  name        = "${var.env}-cje-instance-security-group"
  description = "Security Group for Jenkins Enterprise"
  vpc_id      = "${var.aws_vpc_id}"

  // allow traffic for TCP 22
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.internal_cidr}"]
  }

  // allow traffic for TCP 80
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.internal_cidr}"]
  }

  // allow traffic for TCP 443
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.internal_cidr}"]
  }

  // allow traffic for TCP 8080
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["${var.internal_cidr}"]
  }

  // allow traffic for TCP 80
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.internal_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.external_cidr}"]
  }
}

resource "aws_security_group" "cje_int_elb_sg" {
  name        = "${var.env}-cje-int-elb-sg"
  description = "SG for CJE Internal ELB"

  tags = "${merge(var.tags, map("Name", "cje_int_elb_sg", "Environment", "${var.env}"))}"

  vpc_id = "${var.aws_vpc_id}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.internal_cidr}"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.internal_cidr}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.internal_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.external_cidr}"]
  }
}

resource "aws_security_group" "cje_ext_elb_sg" {
  name        = "${var.env}-cje-ext-elb-sg"
  description = "SG for CJE External ELB"

  tags = "${merge(var.tags, map("Name", "cje_ext_elb_sg", "Environment", "${var.env}"))}"

  vpc_id = "${var.aws_vpc_id}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = []
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.external_cidr}"]
  }
}
