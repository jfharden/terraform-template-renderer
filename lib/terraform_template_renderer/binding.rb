module TerraformTemplateRenderer
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
