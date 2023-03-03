# frozen_string_literal: true

require "date"

module Jekyll
  module Disqus
    #
    # Contains the methods to calculate the Disqus ID associated to
    # a post or a page.
    #
    module Helper
      def disabled_tag?(tag, context)
        return true if context.registers[:page]["no_disqus"]
        return false if context.registers[:site].config["jekyll-disqus"][tag]["layouts"].include?("all")

        layout = context.registers[:page]["layout"]
        return false if context.registers[:site].config["jekyll-disqus"][tag]["layouts"].include?(layout)

        true
      end

      def post_selector(registers)
        registers[:site].config["jekyll-disqus"]["post_selector"] || "include.post"
      end

      def page_disqus_id(registers)
        id = registers[:page]["disqus_id"]
        raise MissingDisqusId, registers[:page]["url"] if id.nil? && registers[:page]["date"].nil?

        begin
          id = DateTime.parse(registers[:page]["date"].to_s).to_time.to_i if id.nil?
        rescue ArgumentError
          raise InvalidDate, registers[:page]["url"]
        end

        registers[:site].config["jekyll-disqus"]["id_prefix"].to_s + id.to_s
      end

      def post_disqus_id(context)
        selector = post_selector(context.registers)
        return unless context["#{selector}.title"]

        id = context["#{selector}.disqus_id"]
        raise MissingDisqusId, registers[:page]["url"] if id.nil? && context["#{selector}.date"].nil?

        begin
          id = DateTime.parse(context["#{selector}.date"].to_s).to_time.to_i if id.nil?
        rescue ArgumentError
          raise InvalidDate, registers[:page]["url"]
        end

        context.registers[:site].config["jekyll-disqus"]["id_prefix"].to_s + id.to_s
      end
    end
  end
end
