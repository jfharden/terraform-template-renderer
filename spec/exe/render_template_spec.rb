RSpec.describe "Executing template-render executable", type: :aruba do
  let(:executable) { File.join(__dir__, "..", "..", "exe", "render-template") }
  let(:fixture_path) { File.join(__dir__, "..", "fixtures") }
  let(:help_text) do
    "Usage: render-template <path_to_erb_template>\n" \
    "\n" \
    "Reads json blob with params from STDIN\n"
  end

  before(:example) { setup_aruba }

  context "help flags" do
    ["help", "--help", "-h", "-help"].each do |help_flag|
      before(:example) do
        run("#{executable} #{help_flag}")
        stop_all_commands
      end

      it "Outputs the help text to stdout and exits successfully" do
        expect(last_command_stopped.stdout).to eq(help_text)
        expect(last_command_stopped.stderr).to eq("")
        expect(last_command_stopped.exit_status).to eq 0
      end
    end
  end

  context "no arguments passed" do
    before(:example) do
      run("#{executable}")
      stop_all_commands
    end

    it "Outputs the brief help text to stderr and exits with error code 1" do
      expect(last_command_stopped.stdout).to eq("")
      expect(last_command_stopped.stderr).to eq("You must supply the path to an ERB template as the first argument\n")
      expect(last_command_stopped.exit_status).to eq 1
    end
  end

  context "Template path doesn't exist" do
    before(:example) do
      run("#{executable} invalid_path")
      stop_all_commands
    end

    it "Outputs an error to stderr and exits with error code 2" do
      expect(last_command_stopped.stdout).to eq("")
      expect(last_command_stopped.stderr).to eq("ERB Template invalid_path does not exist\n")
      expect(last_command_stopped.exit_status).to eq 2
    end
  end

  context "Successful run" do
    context "with a simple template" do
      let(:template_path) { File.join(fixture_path, "simple_template.erb") }
      let(:rendered_path) { File.join(fixture_path, "simple_template.rendered") }

      let(:json) do
        {
          mykey1: "my_value1",
          mykey2: "my_value2"
        }.to_json
      end

      before(:example) do
        run("#{executable} #{template_path}")
        last_command_started.stdin.write(json)
        last_command_started.stdin.close
      end

      it "renders the template to stdout, nothing to stderr and exits successfully" do
        expect(last_command_stopped.stdout).to eq(File.read(rendered_path))
        expect(last_command_stopped.stderr).to eq("")
        expect(last_command_stopped.exit_status).to eq(0)
      end
    end
  end
end
