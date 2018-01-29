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

resource "aws_vpc" "multi_resource_lookup" {
  cidr_block = "10.254.254.0/24"

  tags {
    Name = "terraform-template-renderer-example"
  }
}

resource "aws_subnet" "multi_resource_lookup" {
  vpc_id = "${aws_vpc.multi_resource_lookup.id}"
  cidr_block = "10.254.254.0/24"
  availability_zone = "eu-west-1a"

  tags {
    Name = "terraform-template-renderer-example"
  }
}

data "aws_ami" "multi_resource_lookup" {
  most_recent      = true

  filter {
    name   = "name"
    values = ["amzn-ami-2017.09.*-amazon-ecs-optimized"]
  }

  owners     = ["amazon"]
}

resource "aws_instance" "multi_resource_lookup_1" {
  ami = "${data.aws_ami.multi_resource_lookup.id}"
  instance_type = "t2.nano"
  subnet_id = "${aws_subnet.multi_resource_lookup.id}"

  tags {
    Name = "terraform-template-renderer-example"
    Stage = "Development"
  }
}

resource "aws_instance" "multi_resource_lookup_2" {
  ami = "${data.aws_ami.multi_resource_lookup.id}"
  instance_type = "t2.nano"
  subnet_id = "${aws_subnet.multi_resource_lookup.id}"

  tags {
    Name = "terraform-template-renderer-example"
    Stage = "Development"
  }
}
