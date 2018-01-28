terraform {
  required_version = "~> 0.11.1"
}

provider "external" {
  version = "~> 1.0.0"
}

data "external" "simple_strings" {
  program = ["bundle", "exec", "render-template", "simple_strings.erb"]

  query {
    key1 = "value1" 
    key2 = "value2"
  }
}

resource "local_file" "simple_strings" {
  content = "${data.external.simple_strings.result.rendered}"
  filename = "sample_output"
}
