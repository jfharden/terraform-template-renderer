data "aws_instances" "multi_resource_lookup" {
  instance_tags {
    Stage = "Development"
  }
}

data "external" "multi_resource_lookup" {
  program = ["bundle", "exec", "render-template", "multi_resource_lookup.erb"]

  query {
    count = "${data.aws_instances.multi_resource_lookup.ids.length}"
    instances = "${jsonencode(data.aws_instances.multi_resource_lookup.ids)}"
  }
}

resource "local_file" "multi_resource_lookup" {
  content = "${data.external.multi_resource_lookup.result.rendered}"
  filename = "sample_output"
}
