require "erb"
require "json"

module TerraformTemplateRenderer
  class Renderer
    def initialize(template, template_path)
      # The third argument enables trim mode using a hyphen
      @erb_template = ERB.new(template, nil, "-")
      @template_path = template_path
    end

    # The passed in json_variables needs to be a JSON object (not array), all the keys will be used
    # as variables in the templates
    def render(json_variables)
      binding_ = template_binding(json_variables)
      render_with_binding(binding_)
    end

    def render_with_binding(binding_)
      @erb_template.result(binding_.bind)
    end

    private

    def template_binding(json_variables)
      Binding.new(@template_path).tap { |binding_object| add_params_to_object(binding_object, JSON.parse(json_variables)) }
    end

    def add_params_to_object(object, params)
      params.each do |key, value|
        object.add_param(key, value)
      end
    end
  end
end
