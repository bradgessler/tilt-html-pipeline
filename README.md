# Tilt::HTML::Pipeline

Create custom file extensions in Sinatra and other Tilt compatible frameworks that transform HTML via the [HTML Pipeline](https://github.com/jch/html-pipeline).

[![Build Status](https://travis-ci.org/bradgessler/tilt-html-pipeline.svg)](https://travis-ci.org/bradgessler/tilt-html-pipeline)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tilt-html-pipeline', require: 'tilt/html/pipeline'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tilt-html-pipeline

## Usage

Say you're building an API documentation [site in Sinatra](https://github.com/bradgessler/tilt-html-pipeline-example) and you want all of your markdown to be rendered with a table of contents and code highlighting. Just invent your own `apidoc` file extension!

```ruby
require 'sinatra'
require 'html/pipeline'
require 'tilt/html/pipeline'

Tilt.register_html_pipeline :apidoc, [
  HTML::Pipeline::MarkdownFilter,
  HTML::Pipeline::SyntaxHighlightFilter,
  HTML::Pipeline::TableOfContentsFilter
]

# Renders ./views/index.apidoc
get "/" do
  render(:apidoc, :index)
end
```

Any file that ends in `.apidoc` will be filtered by `HTML::Filter`. Since Tilt lets you chain templates, you could get crazy and include stuff like A/B testing via `index.ab-test.apidoc.erb`.

Pretty cool, huh?

## Contributing

1. Fork it ( https://github.com/bradgessler/tilt-html-pipeline/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

You may also contribute HTML Pipeline filters at https://github.com/jch/html-pipeline.