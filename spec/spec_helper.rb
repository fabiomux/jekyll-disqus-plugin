# frozen_string_literal: true

require "liquid"
require "jekyll-disqus"

def init_mock(disqus_id = nil)
  @context = Liquid::ParseContext.new
  config = double("config")
  allow(config).to receive(:config) do
    {
      "jekyll-disqus" => {
        "shortname" => "shortnametest",
        "id_prefix" => "TP-",
        "ui" => {
          "layouts" => [
            "post"
          ]
        },
        "counter" => {
          "layouts" => [
            "all"
          ]
        }
      }
    }
  end
  allow(@context).to receive(:line_number) { "" }
  allow(@context).to receive(:registers) do
    {
      site: config,
      page: {
        "disqus_id" => disqus_id,
        "layout" => "post"
      }
    }
  end
end

def mock_post(disqus_id = nil)
  init_mock(disqus_id)
  allow(@context).to receive(:[]) do |x|
    case x
    when "include.post.date"
      "2023-02-28 09:56"
    when "include.post.title"
      "Title test"
    when "include.post.disqus_id"
      disqus_id
    end
  end
end

def mock_page
  init_mock("CUSTOM_DISQUS_ID")
  allow(@context).to receive(:[]) do |x|
    case x
    when "include.post.date"
      nil
    when "include.post.title"
      nil
    end
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
