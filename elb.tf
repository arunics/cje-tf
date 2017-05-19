#CJE Internal ELB
resource "aws_elb" "cje_elb_internal" {
  name     = "${var.env}-cje-elb-internal"
  internal = true

  listener {
    instance_port      = 80
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "arn:aws:acm:us-west-2:489012308314:certificate/d83e37e2-bf0c-470e-ad6c-92cb09fde23e"
  }

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 5
    target              = "TCP:80"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  instances                   = ["${aws_instance.cje_controller.*.id}"]
  connection_draining         = true
  connection_draining_timeout = 90
  idle_timeout                = 60
  security_groups             = ["${aws_security_group.cje_int_elb_sg.id}"]
  subnets                     = ["${var.aws_elb_int_subnet_id}"]
  tags                        = "${merge(var.tags, map("Name", "cje_elb_internal","Environment", "${var.env}"))}"
}

#CJE External ELB
resource "aws_elb" "cje_elb_external" {
  name = "${var.env}-cje-elb-external"

  # Lister for HTTPS
  listener {
    instance_port      = 80
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "arn:aws:acm:us-west-2:489012308314:certificate/d83e37e2-bf0c-470e-ad6c-92cb09fde23e"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTPS:443/status"
    interval            = 30
  }

  instances                   = ["${aws_instance.cje_controller.*.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  subnets                     = ["${var.aws_elb_ext_subnet_id}"]
  security_groups             = ["${aws_security_group.cje_ext_elb_sg.id}"]
  tags                        = "${merge(var.tags, map("Name", "cje_elb_external","Environment", "${var.env}"))}"
}
