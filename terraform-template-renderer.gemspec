require_relative "lib/terraform_template_renderer/version"

Gem::Specification.new do |spec|
  spec.name          = "terraform-template-renderer"
  spec.version       = TerraformTemplateRenderer::VERSION
  spec.authors       = ["Jonathan Harden"]
  spec.email         = ["jfharden@gmail.com"]
  spec.license       = "MIT"
  spec.homepage      = "http://github.com/jfharden/terraform-template-renderer"

  spec.summary       = "Renders an aribtrary erb template with passed in JSON variables"
  spec.description   = <<-DESCRIPTION
    Will render an arbitrary erb template (passed as the first positional argument),
    filling variables from a passed in JSON blob, the keys will be used as variable names
    and the values their respective values.

    The purpose of this GEM is to make it easy to render complex templates in terraform in
    a modular and reusable way.
  DESCRIPTION

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = "render-template"
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.3.0"

  spec.add_development_dependency "aruba", "~> 0.14.3"
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "pry-byebug", "~> 3.5"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "rspec", "~> 3.7"
end
