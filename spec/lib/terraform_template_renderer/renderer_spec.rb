require "spec_helper"
require "json"

RSpec.describe TerraformTemplateRenderer::Renderer do
  subject(:renderer) { described_class.new(template) }

  let(:template) { "var thing = '<%= @mykey1 %>'; var other = '<%= @mykey2 %>'" }

  let(:rendered_template) { "var thing = 'my_value1'; var other = 'my_value2'" }
  let(:rendered_template_2) { "var thing = 'my_other_value1'; var other = 'my_other_value2'" }

  let(:json_variables) do
    {
      mykey1: "my_value1",
      mykey2: "my_value2"
    }.to_json
  end
  let(:json_variables_2) do
    {
      mykey1: "my_other_value1",
      mykey2: "my_other_value2"
    }.to_json
  end

  describe "#render" do
    it "produces a rendered template completed with the variables passed in" do
      expect(subject.render(json_variables)).to eq(rendered_template)
    end

    it "produces a freshly rendered template when called a second time with different variables" do
      subject.render(json_variables)
      expect(subject.render(json_variables_2)).to eq(rendered_template_2)
    end
  end
end
