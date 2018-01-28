# terraform-template-renderer

Provides a ruby executable which will take a path to an ERB template as it's only positional argument and render that
with a json blob passed in to STDIN. The keys in the json blob will be used as instance variable names to use in the
template.

The result will be returned inside a json blob with a single key, the name of which is rendered.

For example if your template is

    Hello <%= @my_key %>!

And you execute the command as:

    echo '{ "my_key": "dear reader" }' | template_renderer path_to_my_template

You will produce

    { "rendered": "Hello dear reader!" }

The purpose for this strange behaviour is to be a [terraform external
provider](https://www.terraform.io/docs/providers/external/data_source.html) to render arbitrarily complex templates,
terraform passes in the variables to render as a json blob to stdin as described above and expects a json blob
back.
