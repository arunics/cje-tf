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
    cidr_blocks = ["104.112.3.0/24", "104.118.105.0/24", "106.187.61.0/24", "117.104.138.0/24", "117.239.240.0/25", "165.254.1.0/24", "184.25.157.0/24", "184.25.63.0/24", "184.29.107.0/24", "184.51.101.0/24", "202.239.172.64/26", "204.156.7.0/24", "204.188.136.0/24", "207.86.215.0/24", "209.116.151.0/24", "23.205.116.0/24", "23.215.15.0/24", "23.216.10.0/24", "23.220.148.0/24", "23.4.240.0/24", "23.74.8.0/24", "23.79.240.0/24", "23.79.255.0/24", "59.144.112.128/25", "60.254.143.0/24", "61.9.129.128/25", "63.217.232.0/24", "63.233.60.0/24", "63.233.61.0/24", "72.246.191.0/24", "80.156.248.0/24", "80.239.171.0/24", "95.100.169.0/24", "96.6.47.0/24", "67.220.142.19/32", "67.220.142.20/32", "67.220.142.21/32", "67.220.142.22/32", "66.198.8.141/32", "66.198.8.142/32", "66.198.8.143/32", "66.198.8.144/32", "23.48.168.0/22", "23.50.48.0/20", "50.109.247.9/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.external_cidr}"]
  }
}
