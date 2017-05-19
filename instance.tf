#configure CJE Cluster instances

#select image based on the region
variable "base_ubuntu_image" {
  default = {
    us-east-1 = "ami-772aa961"

    //us-east-2 = "ami-c86144ad"
    us-west-1 = "ami-1da8f27d"
    us-west-2 = "ami-7c22b41c"
  }
}

#configure controller instance
resource "aws_instance" "cje_controller" {
  ami   = "${lookup(var.base_ubuntu_image, var.aws_region)}"
  count = "${var.number_of_controller_instances}"

  #region        = "${var.aws_region}"
  #vpc_id        = "${var.aws_vpc_id}"
  availability_zone = "${element(var.azs, count.index)}"

  subnet_id     = "${element(var.aws_instance_subnet_id, count.index)}"
  key_name      = "${var.aws_ssh_key_name}"
  instance_type = "${var.controller_instance_type}"
  user_data     = "${file(var.user_data)}"

  tags {
    created_by = "${lookup(var.tags,"created_by")}"
    Name       = "${var.env}-cje-controller-${count.index + 1}"
  }

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "200"
    delete_on_termination = false
  }

  vpc_security_group_ids = [
    "${aws_security_group.cje_instance_security_group.id}",
  ]
}

# CJE Worker instance
resource "aws_instance" "cje_worker" {
  ami   = "${lookup(var.base_ubuntu_image, var.aws_region)}"
  count = "${var.number_of_worker_instances}"

  #region        = "${var.aws_region}"
  #vpc_id        = "${var.aws_vpc_id}"
  #subnet_id     = "${var.aws_instance_subnet_id}"
  availability_zone = "${element(var.azs, count.index)}"

  subnet_id     = "${element(var.aws_instance_subnet_id, count.index)}"
  key_name      = "${var.aws_ssh_key_name}"
  instance_type = "${var.worker_instance_type}"
  user_data     = "${file(var.user_data)}"

  tags {
    created_by = "${lookup(var.tags,"created_by")}"
    Name       = "${var.env}-cje-worker-${count.index + 1}"
  }

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "200"
    delete_on_termination = false
  }

  vpc_security_group_ids = [
    "${aws_security_group.cje_instance_security_group.id}",
  ]
}

# CJE elasticsearch instance
resource "aws_instance" "cje_elasticsearch" {
  ami = "${lookup(var.base_ubuntu_image, var.aws_region)}"

  count = "${var.number_of_els_instances}"

  #region        = "${var.aws_region}"
  #vpc_id        = "${var.aws_vpc_id}"
  #subnet_id     = "${var.aws_instance_subnet_id}"
  availability_zone = "${element(var.azs, count.index)}"

  subnet_id     = "${element(var.aws_instance_subnet_id, count.index)}"
  key_name      = "${var.aws_ssh_key_name}"
  instance_type = "${var.elasticsearch_instance_type}"
  user_data     = "${file(var.user_data)}"

  tags {
    created_by = "${lookup(var.tags,"created_by")}"
    Name       = "${var.env}-cje-elasticsearch-${count.index + 1}"
  }

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "200"
    delete_on_termination = false
  }

  vpc_security_group_ids = [
    "${aws_security_group.cje_instance_security_group.id}",
  ]
}
