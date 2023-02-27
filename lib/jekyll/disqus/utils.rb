# frozen_string_literal: true

module Jekyll
  module Disqus
    #
    # Missing Disqus ID field error.
    #
    class MissingDisqusId < StandardError
      def initialize(url)
        super "The page at the URL: #{url} doesn't contains any 'disqus_id' field!"
      end
    end

    #
    # Missing the Shortname param error.
    #
    class MissingShortname < StandardError
      def initialize
        super "The required param 'shortname' is missing!"
      end
    end

    #
    # Duplicated Disqus ID among pages and posts.
    #
    class DuplicatedDisqusId < StandardError
      def initialize(args)
        super "The page at the URL: #{args[:current_url]}
          has same ID of the page at: #{args[duplicated_url]} (#{args[id]})!"
      end
    end
  end
end
