# Build Crushinated URLs

Provides a helper to construct [crushinated](https://github.com/tedconf/crushinator) image URLs.

* Versions < 0.0.5 use Level3 CDN. Versions 0.0.5+ are SSL only

```ruby
# Gemfile
gem 'crushinator_helpers', '0.0.5', git: 'git@github.com:tedconf/crushinator_helpers.git'

# app/helpers/application_helper.rb
module ApplicationHelper
  include CrushinatorHelpers::ViewHelpers
end

# app/views/talks/index.html.erb
<%= crushinate 'http://www.ted.com/image.jpg' %>
```

