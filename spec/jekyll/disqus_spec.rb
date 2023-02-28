# frozen_string_literal: true

require_relative "../../lib/jekyll/disqus/version"

RSpec.describe Jekyll::Disqus do
  it "has a version number" do
    expect(Jekyll::Disqus::VERSION).not_to be nil
  end
end
