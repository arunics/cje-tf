#cname for jenkins Operations center-internal
resource "aws_route53_record" "cje_elb_internal_cname" {
  zone_id = "${var.zone_id}"
  name    = "${var.env}-jenkins-int"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_elb.cje_elb_internal.dns_name}"]
}

#cname for mesos-internal
resource "aws_route53_record" "mesos_cje_elb_internal_cname" {
  zone_id = "${var.zone_id}"
  name    = "${var.env}-mesos-jenkins-int"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_elb.cje_elb_internal.dns_name}"]
}

#cname for marathon-internal
resource "aws_route53_record" "marathon_cje_elb_internal_cname" {
  zone_id = "${var.zone_id}"
  name    = "${var.env}-marahon-jenkins-int"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_elb.cje_elb_internal.dns_name}"]
}

#cname for jenkins Operations center-external
resource "aws_route53_record" "cje_elb_external_cname" {
  zone_id = "${var.zone_id}"
  name    = "${var.env}-jenkins-ext"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_elb.cje_elb_external.dns_name}"]
}
