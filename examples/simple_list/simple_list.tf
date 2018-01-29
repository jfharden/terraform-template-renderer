terraform {
  required_version = "~> 0.11.1"
}

provider "external" {
  version = "~> 1.0.0"
}

variable "simple_list" { default = ["list_value_a", "list_value_2"] }

data "external" "simple_list" {
  program = ["bundle", "exec", "render-template", "simple_list.erb"]

  query {
    list = "${jsonencode(var.simple_list)}"
  }
}

resource "local_file" "simple_list" {
  content = "${data.external.simple_list.result.rendered}"
  filename = "sample_output"
}
