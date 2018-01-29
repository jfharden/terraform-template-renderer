require "erb"
require "json"

module TerraformTemplateRenderer
  class Renderer
    def initialize(template)
      # The third argument enables trim mode using a hyphen
      @erb_template = ERB.new(template, nil, "-")
    end

    # The passed in json_variables needs to be a JSON object (not array), all the keys will be used
    # as variables in the templates
    def render(json_variables)
      @erb_template.result(template_binding(json_variables))
    end

    private

    def template_binding(json_variables)
      Binding.new.tap { |binding_object| add_params_to_object(binding_object, JSON.parse(json_variables)) }.bind
    end

    def add_params_to_object(object, params)
      params.each do |key, value|
        object.add_param(key, value)
      end
    end
  end
end
