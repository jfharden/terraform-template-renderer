data "aws_instances" "cloudwatch_dashboard" {
  instance_tags {
    Stage = "Development"
  }
}

locals {
  aws_instances_by_name = [
    { name = "${aws_instance.cloudwatch_dashboard_1.tags.Name}", id = "${aws_instance.cloudwatch_dashboard_1.id}" },
    { name = "${aws_instance.cloudwatch_dashboard_2.tags.Name}", id = "${aws_instance.cloudwatch_dashboard_2.id}" }
  ]
}

data "external" "cloudwatch_dashboard" {
  program = ["bundle", "exec", "render-template", "cloudwatch_dashboard.erb"]

  query {
    instances_by_name = "${jsonencode(local.aws_instances_by_name)}"
    instances_by_id = "${jsonencode(data.aws_instances.cloudwatch_dashboard.ids)}"
    elb_name = "${aws_elb.cloudwatch_dashboard.name}"    
  }
}

resource "aws_cloudwatch_dashboard" "cloudwatch_dashboard" {
  dashboard_name = "TerraformTemplateRendererExample"
  dashboard_body = "${data.external.cloudwatch_dashboard.result.rendered}"
}

resource "local_file" "cloudwatch_dashboard" {
  content = "${data.external.cloudwatch_dashboard.result.rendered}"
  filename = "sample_output"
}
