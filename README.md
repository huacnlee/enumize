# Enumize

Extend ActiveRecord::Enum for add more helpful methods, from [rails/rails#36503](https://github.com/rails/rails/pull/36503).

## Usage

```rb
class Book
  enum status: %i[draft published archived]
end
```

Now we have `status_name`, `status_color`, `status_value` and `Book.status_options` methods:

- `#{attribute}_name` - return I18n name for display.
- `#{attribute}_color` - return color for enum value from I18n file.
- `#{attribute}_value` - return raw value for enum, Now we don't need use `Book.statuses[@book.status]`.
- `Book.#{attribute}_options` - return a array list for select tag options, `<%= f.select :status, Book.status_options %>`.

Write I18n:

```yml
en:
  activerecord:
    enums:
      book:
        status:
          draft: Drafting
          published: Published
          archived: Archived
        status_color:
          draft: "#999999"
          published: "green"
          archived: "red"

zh-CN:
  activerecord:
    enums:
      book:
        status:
          draft: "草稿"
          published: "已发布"
          archived: "归档"
```

use the methods:

```rb
irb> @book = Book.new(status: :draft)
irb> @book.status_value
0
irb> @book.status_name
"草稿"
irb> @book.status_color
"#999999"
```

For `_options` methods for `select` helper:

```erb
<% form_for(@book) do |f| %>
  <%= f.text_field :name %>
  <%= f.select :status, Book.status_options %>
  <%= f.submit %>
<% end >
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'enumize'
```

And then execute:
```bash
$ bundle
```

## Configure the I18n fallbacks for `color` method

You can write color config in `en.yml` once for all locales, so follow the I18n fallback, the others locale will
use color value from `en`:

config/application.rb

```rb
module Dummy
  class Application < Rails::Application
    # Add to tell I18n fallback translate to en
    config.i18n.available_locales = ["en", "zh-CN"]
    config.i18n.fallbacks = true
  end
end
````

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
