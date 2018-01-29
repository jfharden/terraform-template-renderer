terraform {
  required_version = "~> 0.11.1"
}

provider "external" {
  version = "~> 1.0.0"
}

data "external" "json_encoded_hash" {
  program = ["bundle", "exec", "render-template", "json_encoded_hash.erb"]

  query {
    hash = <<EOF
{
  "key1": "value1",
  "key2": "value2"
}
EOF
  }
}

resource "local_file" "json_encoded_hash" {
  content = "${data.external.json_encoded_hash.result.rendered}"
  filename = "sample_output"
}
