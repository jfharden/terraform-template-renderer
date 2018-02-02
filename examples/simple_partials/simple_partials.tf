terraform {
  required_version = "~> 0.11.1"
}

provider "external" {
  version = "~> 1.0.0"
}

data "external" "simple_partials" {
  program = ["bundle", "exec", "render-template", "simple_partials.erb"]

  query {
    key1 = "value1"
    key2 = "value2"
    partial_key_1 = "partial_value_1"
    partial_key_2 = "partial_value_2"
  }
}

resource "local_file" "simple_partials" {
  content = "${data.external.simple_partials.result.rendered}"
  filename = "sample_output"
}
