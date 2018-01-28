require "spec_helper"

RSpec.describe TerraformTemplateRenderer::Binding do
  subject(:binding) { described_class.new }
  let(:key) { "my_key" }
  let(:value) { "my_value" }

  describe "#add_param" do
    it "Adds the passed in key as an instance variable" do
      expect { binding.add_param(key, value) }.
        to change { binding.instance_variable_get("@#{key}") }.
        from(nil).to(value)
    end
  end

  describe "#bind" do
    it "returns a plain ruby Binding object" do
      expect(subject.bind).to be_instance_of(::Binding)
    end

    it "returns a binding context for our subject" do
      expect(subject.bind.receiver).to be subject
    end

    it "generates a new binding each time which don't share execution context" do
      binding1 = subject.bind.tap { |b1| b1.instance_variable_set("@test_variable", "test_value_before_1") }
      binding2 = subject.bind.tap { |b2| b2.instance_variable_set("@test_variable", "test_value_before_2") }

      expect { binding1.instance_variable_set("@test_variable", "test_value_after_1") }.
        not_to change { binding2.instance_variable_get("@test_variable") }.from("test_value_before_2")
    end
  end
end
