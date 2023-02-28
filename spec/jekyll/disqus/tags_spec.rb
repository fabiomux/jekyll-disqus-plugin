# frozen_string_literal: true

RSpec.describe Jekyll::Disqus::Counter do
  it "Prints the counter for a post using the date" do
    mock_post

    c = Jekyll::Disqus::Counter.send :new, "disqus_counter", "{% disqus_counter %}", @context
    expect(c.render(@context)).to \
      eq "<span class=\"disqus-comment-count\" data-disqus-identifier=\"TP-1677578160\">Comments</span>"
  end

  it "Prints the counter for a post using the disqus_id" do
    mock_post("CUSTOM_DISQUS_ID")

    c = Jekyll::Disqus::Counter.send :new, "disqus_counter", "{% disqus_counter %}", @context
    expect(c.render(@context)).to \
      eq "<span class=\"disqus-comment-count\" data-disqus-identifier=\"TP-CUSTOM_DISQUS_ID\">Comments</span>"
  end

  it "Prints the counter for a page using the disqus_id" do
    mock_page

    c = Jekyll::Disqus::Counter.send :new, "disqus_counter", "{% disqus_counter %}", @context
    expect(c.render(@context)).to \
      eq "<span class=\"disqus-comment-count\" data-disqus-identifier=\"TP-CUSTOM_DISQUS_ID\">Comments</span>"
  end
end

RSpec.describe Jekyll::Disqus::ScriptCounter do
  it "Prints the Javascript code for the counter" do
    mock_page

    c = Jekyll::Disqus::ScriptCounter.send :new, "disqus_script_counter", "{% disqus_script_counter %}", @context
    expect(c.render(@context).gsub(/\n/, " ").gsub(/ +/, " ").strip).to \
      eq "<script id=\"dsq-count-scr\" src=\"//shortnametest.disqus.com/count.js\" async></script>"
  end
end

RSpec.describe Jekyll::Disqus::ScriptUI do
  it "Prints the Javascript code for the UI comment box" do
    mock_page

    c = Jekyll::Disqus::ScriptUI.send :new, "disqus_script_ui", "{% disqus_script_ui %}", @context
    expect(c.render(@context).gsub(/\n/, " ").gsub(/ +/, " ").strip).to \
      eq "<script> var disqus_config = function () { this.page.url = ''; this.page.identifier = 'TP-CUSTOM_DISQUS_ID';
 }; (function() { var d = document, s = d.createElement('script'); s.src = '//shortnametest.disqus.com/embed.js';
 s.setAttribute('data-timestamp', +new Date()); (d.head || d.body).appendChild(s); })(); </script> <noscript>
 Please enable JavaScript to view the <a href=\"https://disqus.com/?ref_noscript\">comments powered by
 Disqus.</a> </noscript>".gsub(/\n/, " ").gsub(/ +/, " ")
  end
end
