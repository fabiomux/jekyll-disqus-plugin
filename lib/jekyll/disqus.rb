# frozen_string_literal: true

require "jekyll"

require_relative "disqus/helper"
require_relative "disqus/tags"
require_relative "disqus/utils"

Liquid::Template.register_tag("disqus_ui", Jekyll::Disqus::UI)
Liquid::Template.register_tag("disqus_script_ui", Jekyll::Disqus::ScriptUI)
Liquid::Template.register_tag("disqus_counter", Jekyll::Disqus::Counter)
Liquid::Template.register_tag("disqus_script_counter", Jekyll::Disqus::ScriptCounter)
