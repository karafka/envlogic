# Envlogic [Unmaintained]

Note: This library is no longer in use in the Karafka ecosystem. It was developed for Karafka versions prior to 2.0.

[![Build Status](https://github.com/karafka/envlogic/workflows/ci/badge.svg)](https://github.com/karafka/envlogic/actions?query=workflow%3Aci)
[![Gem Version](https://badge.fury.io/rb/envlogic.svg)](http://badge.fury.io/rb/envlogic)
[![Join the chat at https://slack.karafka.io](https://raw.githubusercontent.com/karafka/misc/master/slack.svg)](https://slack.karafka.io)

Envlogic is a library used to manage environments for your Ruby application in a similar to Rails.env way.

## Installation

Add the gem to your Gemfile
```ruby
  gem 'envlogic'
```

## Usage

### On a class/module level

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

### On a per instance basis

Include the **Envlogic** module in the class for which instances you want to use it.

```ruby
class ExampleClass
  include Envlogic
  # code of this class
end
```

Once you include it in your class, you will have two additional methods (with two aliases):

 - *.env* (.environment) - obtain current env and work with it
 - *.env=* (.environment=) - set your own environment

```ruby
  instance = ExampleClass.new
  instance.env = 'development'
  instance.env.development? # => true
  instance.env.production? # => false
```

### ENV variables key names and default fallbacks

#### Application root directory env key name

By default, the gem is looking for ENV variable that is based on your application root directory.

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
* [Envlogic Actions CI](https://github.com/karafka/envlogic/actions?query=workflow%3Aci)
* [Envlogic Coditsu](https://app.coditsu.io/karafka/repositories/envlogic)

## Note on contributions

First, thank you for considering contributing to the Karafka ecosystem! It's people like you that make the open source community such a great community!

Each pull request must pass all the RSpec specs, integration tests and meet our quality requirements.

Fork it, update and wait for the Github Actions results.
