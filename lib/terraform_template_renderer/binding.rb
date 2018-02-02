# frozen_string_literal: true

module TerraformTemplateRenderer
  # Provides a Binding context which we can add arbitrary params to (which will become instance
  # variables for the templates when they get rendered). Also provides a method to render
  # partial templates which will pass through itself as the binding context for the partial
  # template
  class Binding
    def initialize(template_path)
      @template_path = template_path
    end

    def add_param(key, value)
      instance_variable_set("@#{key}", value)
    end

    def bind
      binding
    end

    def render(partial_path)
      path_to_partial = File.join(@template_path, partial_path)
      renderer = Renderer.new(File.read(path_to_partial), @template_path)

      renderer.render_with_binding(self)
    end
  end
end
