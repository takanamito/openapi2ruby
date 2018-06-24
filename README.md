# Openapi2ruby

[![Build Status](https://travis-ci.com/takanamito/openapi2ruby.svg?branch=master)](https://travis-ci.com/takanamito/openapi2ruby)

A library to generate ruby class from openapi.yaml.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'openapi2ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install openapi2ruby

## Usage

You can generate ruby class from openapi.yaml (Now support OpenAPI Specification 3.0 only)

For example, you uses OpenAPI-Specification [link-example schema](https://github.com/OAI/OpenAPI-Specification/blob/master/examples/v3.0/link-example.yaml#L178-L203).

```sh
# generate ruby class
$ openapi2ruby generate path/to/link-example.yaml --out ./

$ ls
pullrequest_serializer.rb repository_serializer.rb  user_serializer.rb
```

Generated class is below.  
Default, this gem generates `ActiveModel::Serializer` class.

```ruby
class RepositorySerializer < ActiveModel::Serializer
  attributes :slug, :owner

  def owner
    UserSerializer.new(object.user)
  end


  def slug
    type_check(:slug, [String])
    object.slug
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
```

### Use original template

If you wants to generate from other template with ERB.  
You can specify it with cli option.

Write original template.

```erb
class <%= @schema.name %>
  attr_accessor <%= @schema.properties.map{ |p| ":#{p.name}" }.join(', ') %>

  def intiialize(args)
    <%- @schema.properties.each do |p| -%>
    <%= "@#{p.name} = args[:#{p.name}]" %>
    <%- end -%>
  end
end
```

Generate with `--template` option.

```sh
$ openapi2ruby generate path/to/link-example.yaml \
  --template path/to/original_template.rb.erb \
  --out ./
```

```ruby
class Repository
  attr_accessor :slug, :owner

  def intiialize(args)
    @slug = args[:slug]
    @owner = args[:owner]
  end
end
```

For more template value information, please check [default template](https://github.com/takanamito/openapi2ruby/blob/master/lib/openapi2ruby/templates/serializer.rb.erb).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/openapi2ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Openapi2ruby project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/takanamito/openapi2ruby/blob/master/CODE_OF_CONDUCT.md).
