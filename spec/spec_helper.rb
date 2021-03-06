require "bundler/setup"
require "aruba/rspec"
require_relative "../lib/terraform_template_renderer"

RSpec.configure do |config|
  # Include Aruba for testing executable
  config.include Aruba::Api

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.default_formatter = "doc" if config.files_to_run.one?

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.order = :random
  Kernel.srand config.seed
end
