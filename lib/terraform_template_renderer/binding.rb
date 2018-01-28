module TerraformTemplateRenderer
  class Binding
    def add_param(key, value)
      instance_variable_set("@#{key}", value)
    end

    def bind
      binding
    end
  end
end
