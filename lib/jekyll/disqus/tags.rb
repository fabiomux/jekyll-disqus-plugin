# frozen_string_literal: true

module Jekyll
  module Disqus
    #
    # Anchor tag where rendering the comment box.
    #
    class UI < Liquid::Tag
      def initialize(tag_name, text, tokens)
        super
        @text = text
      end

      def render(context)
        return "" if disabled_tag?("ui", context)

        "<div id=\"disqus_thread\"></div>"
      end
    end

    #
    # Anchor tag where rendering the comment counter.
    #
    class Counter < Liquid::Tag
      include Helper

      def initialize(tag_name, text, tokens)
        super
        params = text.scan(/(\w+)=(?:["'])([^'"]+)\K/).to_h
        @label = params.key("label") || "Comments"
      end

      def render(context)
        return "" if disabled_tag?("counter", context)

        id = post_disqus_id(context)
        id = page_disqus_id(context.registers) if id.nil?
        return "" if id.nil?

        "<span class=\"disqus-comment-count\" data-disqus-identifier=\"#{id}\">#{@label}</span>"
      end
    end

    #
    # Print the Javascript code to render the counter.
    #
    class ScriptCounter < Liquid::Tag
      include Helper

      def initialize(tag_name, text, tokens)
        super
        @text = text
      end

      def render(context)
        return "" if disabled_tag?("counter", context)

        "<script
          id=\"dsq-count-scr\"
          src=\"//#{context.registers[:site].config["jekyll-disqus"]["shortname"]}.disqus.com/count.js\"
          async></script>".gsub(/\n/, " ").gsub(/ +/, " ")
      end
    end

    #
    # Print the Javascript code to render the comment box.
    #
    class ScriptUI < Liquid::Tag
      include Helper

      @@ids = {}

      def initialize(tag_name, param, tokens)
        super
        @param = param
      end

      def render(context)
        return "" if disabled_tag?("ui", context)

        raise MissingShortname unless context.registers[:site].config["jekyll-disqus"]["shortname"]

        id = page_disqus_id(context.registers)
        url = context.registers[:page]["url"]
        if @@ids.key?(id) && (@@ids[id] != url)
          raise DuplicatedDisqusId, { current_url: url, duplicated_url: @@ids[id], id: id }
        end

        @@ids[id] = url
        js_string(base_url: context.registers[:site].config["url"],
                  page_url: url,
                  disqus_shortname: context.registers[:site].config["jekyll-disqus"]["shortname"],
                  disqus_id: id)
      end

      private

      def js_string(args)
        "<script>
          var disqus_config = function () {
            this.page.url = '#{args[:base_url]}#{args[:page_url]}';
            this.page.identifier = '#{args[:disqus_id]}';
          };
          (function() {
            var d = document, s = d.createElement('script');
            s.src = '//#{args[:disqus_shortname]}.disqus.com/embed.js';
            s.setAttribute('data-timestamp', +new Date());
            (d.head || d.body).appendChild(s);
          })();
        </script>
        <noscript>
          Please enable JavaScript to view the
          <a href=\"https://disqus.com/?ref_noscript\">comments powered by Disqus.</a>
        </noscript>"
      end
    end
  end
end
