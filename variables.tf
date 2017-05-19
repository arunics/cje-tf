# Configure the AWS Provider

# AWS Specific configuration
variable "aws_access_key" {
  description = "Access key used to create instances"
}

variable "aws_secret_key" {
  description = "Secret key used to create instances"
}

variable "aws_region" {
  description = "Region where instances get created"
}

variable "aws_vpc_id" {
  description = "The VPC ID where the instances should reside"
}

variable "aws_instance_subnet_id" {
  description = "The subnet-id to be used for the instances"
  type        = "list"
  default     = ["subnet-870b03e3", "subnet-7e4f6d08"]
}

variable "aws_elb_int_subnet_id" {
  description = "The subnet-id to be used for internal elb"
  default     = ["subnet-870b03e3", "subnet-7e4f6d08", "subnet-6847dc30"]
}

variable "aws_elb_ext_subnet_id" {
  description = "The subnet-id to be used for external elb"
  default     = ["subnet-a5e39efd", "subnet-34999b42", "subnet-090c046d"]
}

variable "aws_ssh_key_name" {
  description = "The SSH key to be used for the instances"
}

variable "worker_instance_type" {
  description = "instance type for the workers machines"
  default     = "m4.xlarge"
}

variable "controller_instance_type" {
  description = "instance type for the controller machines"
  default     = "m4.large"
}

variable "elasticsearch_instance_type" {
  description = "instance type for the elasticsearch machines"
  default     = "r4.large"
}

variable "number_of_controller_instances" {
  description = "number of instances to make"
  default     = 3
}

variable "number_of_worker_instances" {
  description = "number of instances to make"
  default     = 3
}

variable "number_of_els_instances" {
  description = "number of instances to make"
  default     = 1
}

variable "user_data" {
  description = "The path to a file with user_data for the instances"
}

variable "internal_cidr" {
  description = "CIDR Block for Nike Internal Address"
  default     = ["10.0.0.0/8", "146.197.0.0/16"]
}

variable "external_cidr" {
  description = "CIDR Block for External Access"
  default     = ["0.0.0.0/0"]
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

variable "tags" {
  default = {
    created_by = "terraform"
  }
}

variable "env" {
  description = "cluster env name"
  default     = "dev"
}

variable "azs" {
  description = "Run the EC2 Instances in these Availability Zones"
  type        = "list"
  default     = ["us-west-2a", "us-west-2b"]
}

variable "zone_id" {
  description = "Zone ID for managing DNS / Alias"
  default     = "Z322C9V5A2Y42W"
}
