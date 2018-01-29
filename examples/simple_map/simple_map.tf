terraform {
  required_version = "~> 0.11.1"
}

provider "external" {
  version = "~> 1.0.0"
}

variable "simple_map" {
  default = {
    key1 = "value1"
    key2 = "value2"
  }
} 

data "external" "simple_map" {
  program = ["bundle", "exec", "render-template", "simple_map.erb"]

  query {
    map = "${jsonencode(var.simple_map)}"
  }
}

resource "local_file" "simple_map" {
  content = "${data.external.simple_map.result.rendered}"
  filename = "sample_output"
}
