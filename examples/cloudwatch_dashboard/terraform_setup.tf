terraform {
  required_version = "~> 0.11.1"
}

provider "external" {
  version = "~> 1.0.0"
}

provider "aws" {
  version = "~> 1.7"
  region = "eu-west-1"
}

resource "aws_vpc" "cloudwatch_dashboard" {
  cidr_block = "10.254.254.0/24"

  tags {
    Name = "terraform-template-renderer-example"
  }
}

resource "aws_internet_gateway" "cloudwatch_dashboard" {
  vpc_id = "${aws_vpc.cloudwatch_dashboard.id}"

  tags {
    Name = "terraform-template-renderer-example"
  }
}

resource "aws_subnet" "cloudwatch_dashboard" {
  vpc_id = "${aws_vpc.cloudwatch_dashboard.id}"
  cidr_block = "10.254.254.0/24"
  availability_zone = "eu-west-1a"

  tags {
    Name = "terraform-template-renderer-example"
  }
}

data "aws_ami" "cloudwatch_dashboard" {
  most_recent      = true

  filter {
    name   = "name"
    values = ["amzn-ami-2017.09.*-amazon-ecs-optimized"]
  }

  owners     = ["amazon"]
}

resource "aws_instance" "cloudwatch_dashboard_1" {
  ami = "${data.aws_ami.cloudwatch_dashboard.id}"
  instance_type = "t2.nano"
  subnet_id = "${aws_subnet.cloudwatch_dashboard.id}"

  tags {
    Name = "terraform-template-renderer-example-1"
    Stage = "Development"
  }
}

resource "aws_instance" "cloudwatch_dashboard_2" {
  ami = "${data.aws_ami.cloudwatch_dashboard.id}"
  instance_type = "t2.nano"
  subnet_id = "${aws_subnet.cloudwatch_dashboard.id}"

  tags {
    Name = "terraform-template-renderer-example-2"
    Stage = "Development"
  }
}

resource "aws_elb" "cloudwatch_dashboard" {
  name = "terraform-template-renderer-ex"
  subnets = ["${aws_subnet.cloudwatch_dashboard.id}"]

  instances = [
    "${aws_instance.cloudwatch_dashboard_1.id}",
    "${aws_instance.cloudwatch_dashboard_2.id}"
  ]

  listener {
    instance_port = 80
    instance_protocol = "HTTP"
    lb_port = 80
    lb_protocol = "HTTP"
  }

  tags {
    Name = "terraform-template-renderer-example"
    Stage = "Development"
  }

  depends_on = [
    "aws_internet_gateway.cloudwatch_dashboard"
  ]
}
