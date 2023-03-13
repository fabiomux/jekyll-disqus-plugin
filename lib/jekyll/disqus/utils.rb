# frozen_string_literal: true

module Jekyll
  module Disqus
    #
    # Invalid date format.
    #
    class InvalidDate < StandardError
      def initialize(url)
        super "The page at the URL: #{url} doesn't contains a valid 'date' field!"
      end
    end

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
        super "The required Disqus param 'shortname' is missing!"
      end
    end

    #
    # Duplicated Disqus ID among pages and posts.
    #
    class DuplicatedDisqusId < StandardError
      def initialize(args)
        super "The page at the URL: #{args[:current_url]}
          has the same Disqus ID of: #{args[:duplicated_url]} (#{args[:id]})!"
      end
    end
  end
end
