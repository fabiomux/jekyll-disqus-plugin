# frozen_string_literal: true

require "date"

module Jekyll
  module Disqus
    #
    # Contains the Disqus id calculation that bind a comment box
    #   to a post or a page.
    #
    module Helper
      def post_selector(registers)
        registers[:site].config["jekyll_disqus"]["post_selector"] || "include.post"
      end

      def page_disqus_id(registers)
        id = registers[:page]["disqus_id"]
        id = DateTime.parse(registers[:page]["date"].to_s).to_time.to_i if id.nil?
        raise MissingDisqusId, registers[:page]["url"] if id.nil?

        registers[:site].config["jekyll_disqus"]["id_prefix"].to_s + id.to_s
      end

      def post_disqus_id(context)
        selector = post_selector(context.registers)
        return unless context["#{selector}.title"]

        id = context["#{selector}.disqus_id"]
        id = DateTime.parse(context["#{selector}.date"].to_s).to_time.to_i if id.nil?
        raise MissingDisqusId, registers[:page]["url"] if id.nil?

        context.registers[:site].config["jekyll_disqus"]["id_prefix"].to_s + id.to_s
      end
    end
  end
end
