# ConfirmedAttributes

Confirmed attributes for ActiveRecord.

Adds functionality confirmable attributes to models.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'confirmed_attributes'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install confirmed_attributes

## Usage

Add confirmable_attribute method to your model:

```ruby
class User < ActiveRecord::Base
  confirmable_attribute :email
end
```

And use it:

```ruby
@user User.create email: "your_mail"

@user.confirmable_attributes # => [:email]
User.confirmable_attributes # => [:email]
@user.confimed_attributes # => []
@user.confirmed_attribute? :email # => false

@user.confirm :email
@user.confimed_attributes # => [#<ConfirmedAttributes::Control:0x007f2eacd2f730> name: "email", value: "your_mail"...]
@user.confirmed_attribute? :email # => true
```

Simple, yeah?

## Contributing

1. Fork it ( https://github.com/[my-github-username]/confirmed_attributes/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
