# Envlogic

[![Build Status](https://travis-ci.org/karafka/envlogic.png)](https://travis-ci.org/karafka/envlogic)
[![Code Climate](https://codeclimate.com/github/karafka/envlogic/badges/gpa.svg)](https://codeclimate.com/github/karafka/envlogic)

Envlogic is a library used to manage environments for your Ruby application in a similar to Rails.env way.

## Installation

Add gem to your Gemfile
```ruby
  gem 'envlogic'
```

## Usage

Extend your class or module in which you want to use this library with **Envlogic** module.

```ruby
module ExampleModule
  extend Envlogic
  # code of this module
end
```

Once you extend your class/module with it, you will have two additional methods (with two aliases):

 - *.env* (.environment) - obtain current env and work with it
 - *.env=* (.environment=) - set your own environment

```ruby
  ExampleModule.env = 'development'
  ExampleModule.env.development? # => true
  ExampleModule.env.production? # => false
```

### ENV variables key names and default fallbacks

#### Application root directory env key name

By default gem is looking for ENV variable that is based on your application root directory.

For example, if your application lies in */home/deploy/my_app* it will look for **MY_APP_ENV** variable.

#### Module/class name based env key name

If there's no env value under the app directory name key, it will fallback to the module/class based env variable name (including the whole namespace chain):

```ruby
module Basic
  module Karafka
    extend Envlogic
    # code of Karafka module
  end
end
```

```ruby
ENV['FACEBOOK_API_ENV'] = nil
ENV['BASIC_KARAFKA_ENV'] = 'development'

Basic::Karafka.env.production? # => false
Basic::Karafka.env.development? # => true
```

#### Default fallbacks

If there's no other way to determine the environment, Envlogic will fallback to ENV['RACK_ENV'] and if it fails, it will just assume that we're in 'development' mode.

You can also assign the environment directly in Ruby:

```ruby
module Basic
  module Karafka
    extend Envlogic
    # code of Karafka module
  end
end

Basic::Karafka.env = :development
Basic::Karafka.env.production? # => false
Basic::Karafka.env.development? # => true
```

## References

 * [Karafka framework](https://github.com/karafka/karafka)
 * [Waterdrop](https://github.com/karafka/waterdrop)
 * [Envlogic](https://github.com/karafka/envlogic)
 * [Sidekiq Glass](https://github.com/karafka/sidekiq-glass)

## Note on Patches/Pull Requests

Fork the project.
Make your feature addition or bug fix.
Add tests for it. This is important so I don't break it in a future version unintentionally.
Commit, do not mess with Rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull). Send me a pull request. Bonus points for topic branches.

Each pull request must pass our quality requirements. To check if everything is as it should be, we use [PolishGeeks Dev Tools](https://github.com/polishgeeks/polishgeeks-dev-tools) that combine multiple linters and code analyzers. Please run:

```bash
bundle exec rake
```

to check if everything is in order. After that you can submit a pull request.
