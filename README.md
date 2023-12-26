# Jekyll-Disqus

This is a Jekyll plugin that provides the Liquid tags to render the Disqus Javascript codes inside the
theme template.

It also associates a different *ID* to every *post* using its publishing date and ensures the uniqueness
of that ID among all the posts.

Although the *ID* can be automatically generated is still possible to declare a custom *ID*, which is 
mandatory for those pages that don't contain a publishing date but recall one of the Disqus tags in 
their layouts.

[![Ruby](https://github.com/fabiomux/jekyll-disqus-plugin/actions/workflows/main.yml/badge.svg)][wf_main]
[![Gem Version](https://badge.fury.io/rb/jekyll-disqus-plugin.svg)][gem_version]

## Installation

Can install the gem either manually or using *Bundler*.

### Using Bundler

Install the gem and add to the application's Gemfile by executing:

    $ bundle add jekyll-disqus-plugin --group jekyll_plugins

### Manually

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install jekyll-disqus-plugin

Then, add the following code within the Gemfile of your Jekyll project:

    ```ruby
    group :jekyll_plugins do
      ...
      gem 'jekyll-disqus-plugin'
    end
    ```

## Configuration

Inside the `_config.yml` file can set up the following fields:
```yaml
jekyll-disqus:
  shortname:
  id_prefix: 
  post_selector: 'include.post'
  ui:
    layouts:
    - 'post'
  counter:
    layouts:
    - 'all'
```

*shortname*
: It is the same *Shortname* provided by Disqus for each site added.

*id_prefix*
: It is a code that will be prepended to any *Disqus Id*, just to add another level of customization.

*post_selector*
: This is how the script will read the post data inside a paginator layout.

*ui.layouts*/*counter.layouts*
: A list of layouts where the two couple of tags will be printed.

To disable the tags for specific pages or posts, the *no_disqus* field can be set up to true on the front
matter of the specific post or page itself.

By default, this addon associates a unique *ID* to each *post* using the related publishing date, but
where needed, a *disqus_id* field can be declared in the front matter of the page. 
```yaml
---
title: ...
description: ...
author: ...
...
disqus_id: 'CUSTOM_DISQUS_ID'
...
```

There is a deep relationship between the *disqus_id* and the related post, so be sure that:
- The custom disqus_id will remain unique, otherwise an error will be raised at the building time;
- the custom disqus_id won't change after the page has been published, otherwise all the comments
    associated with the post will be lost;
- the publishing date, where the *ID* is not customized, doesn't change, or all the comments associated
    with the post will be lost.

## Usage

Below are the provided tags:

|            Tag              |                      Description                    | Template |
|:---------------------------:|-----------------------------------------------------|:--------:|
| {% disqus_counter %}        |The count of comments for a certain post             |   Post   |
| {% disqus_script_counter %} |The required Javascript that renders the counter     |  Default |
| {% disqus_ui %}             |The comment box                                      |   Post   |
| {% disqus_script_ui %}      |The required Javascript that renders the comment box |  Default |

The *script* tags must be included once for page and, providing a Javascript code, their position should
be in the bottom part of the main layout, just before the end of the *body* HTML tag.

The *disqus_ui* renders the comment box and should be put in the post or page layout, depending
where you want to show it, usually after the *content* has been printed.

The *disqus_counter* shows the number of comments for a  post (or page), and it is 
bound to the specific content through the *disqus_id* aforementioned.
Usually, it is displayed among the content *data*, just after the title, and it works for the full
rendered post as well as the paginated content.

In the last case, the plugin will detect the post included in the pagination template using a selector.
By default, it is `include.post`, but can be changed in the configuration section of the `_config.yml`
file.

## More Help

- the [project page on the Freeaptitude blog][project_page];
- the [Jekyll-Disqus Github wiki][jekyll_disqus_wiki].

[project_page]: https://freeaptitude.altervista.org/projects/jekyll-disqus.html "Project page on the Freeaptitude blog"
[jekyll_disqus_wiki]: https://github.com/fabiomux/jekyll-disqus-plugin/wiki "Jekyll-Disqus wiki page on GitHub"
[wf_main]: https://github.com/fabiomux/jekyll-disqus-plugin/actions/workflows/main.yml
[gem_version]: https://badge.fury.io/rb/jekyll-disqus-plugin
