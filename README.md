# Build Crushinated URLs
<!--- project_def -->
Provides a helper to construct [crushinated](https://github.com/tedconf/crushinator) image URLs.

Vertical: Hero

Related links: https://github.com/tedconf/crushinator_helpers
<!--- /project_def -->

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
## Doing a release
1. update `lib/version.rb`. follow [semver](http://semver.org/) versioning.
1. change the 'Unreleased' section of `CHANGELOG.md` to the new version number,
   and start a fresh 'Unreleased' section for future changes.
1. `git add -A && git commit && git push`
1. `bundle exec rake release`. This tags a release on github, and pushes the
      generated gem to our private gem server.
1. Paste changelog notes into [the GitHub releases page](https://github.com/tedconf/crushinator_helpers/releases).
   1. Click the link for the release tag. The link's text will initially be set to the version number (e.g. "v0.0.8")
   1. On the subsequent landing page click the "Edit tag" button.

The push will fail if you don't have write access to our private gem server.
See [this tech guide](https://tech-guides.ted.com/guides/infrastructure/working_with_our_private_gem_server.html)
for information on how to obtain a key.
