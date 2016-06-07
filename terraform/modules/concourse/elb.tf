
resource "aws_elb" "concourse_elb" {
  name = "${var.stack_description}-Concourse-${var.concourse_az}"
  subnets = ["${split(",", var.elb_subnets)}"]
  security_groups = ["${split(",", var.elb_security_groups)}"]

  listener {
    instance_port = 8080
    instance_protocol = "tcp"
    lb_port = 80
    lb_protocol = "tcp"
  }

  /* TODO: Make sure we can upload certs for use */
  /* TODO: Make sure that the cert can ref either "arn:aws" or "arn:aws-us-gov" */
  # listener {
  #   instance_port = 8080
  #   instance_protocol = "tcp"
  #   lb_port = 443
  #   lb_protocol = "ssl"
  #   ssl_certificate_id = "arn:aws:iam::${var.account_id}:server-certificate/${var.elb_cert_name}"
  # }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 10
    timeout = 5
    target = "tcp:8080"
    interval = 30
  }

  tags =  {
    Name = "${var.stack_description}-Concourse-${var.concourse_az}"
  }

}