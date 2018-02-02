require "spec_helper"
require "json"

RSpec.describe TerraformTemplateRenderer::Renderer do
  subject(:renderer) { described_class.new(template, template_path) }
  let(:template_path) { "spec/fixtures" }

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

    context "with extra whitespace in the template" do
      let(:template) { "    <%- -%>\nvar thing = '<%= @mykey1 %>'; var other = '<%= @mykey2 -%>\n'" }

      it "allows trimming whitespace with a hypen" do
        expect(subject.render(json_variables)).to eq(rendered_template)
      end
    end
  end

  describe "#render_with_binding" do
    let(:template_binding) { TerraformTemplateRenderer::Binding.new(template_path) }

    it "produces a rendered template completed with the variables passed in" do
      template_binding.add_param("mykey1", "my_value1")
      template_binding.add_param("mykey2", "my_value2")
      expect(subject.render_with_binding(template_binding)).to eq(rendered_template)
    end
  end

  context "with a partial in the template" do
    let(:template) do
      "<%= render 'partial.erb' %>"
    end
    let(:json_for_partial) do
      {
        mykey1: "my_value1",
        mykey2: "my_value2",
        partialkey: "bar"
      }.to_json
    end
    let(:rendered_with_partial) { "var foo = 'bar'\n" }

    it "renders the template including the partial" do
      expect(subject.render(json_for_partial)).to eq(rendered_with_partial)
    end
  end
end
