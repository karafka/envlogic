# Envlogic

[![Build Status](https://travis-ci.org/karafka/envlogic.svg)](https://travis-ci.org/karafka/envlogic)
[![Join the chat at https://gitter.im/karafka/karafka](https://badges.gitter.im/karafka/karafka.svg)](https://gitter.im/karafka/karafka?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Envlogic is a library used to manage environments for your Ruby application in a similar to Rails.env way.

## Installation

Add the gem to your Gemfile
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
* [Envlogic Travis CI](https://travis-ci.org/karafka/envlogic)
* [Envlogic Coditsu](https://app.coditsu.io/karafka/repositories/envlogic)

## Note on contributions

First, thank you for considering contributing to Envlogic! It's people like you that make the open source community such a great community!

Each pull request must pass all the RSpec specs and meet our quality requirements.

To check if everything is as it should be, we use [Coditsu](https://coditsu.io) that combines multiple linters and code analyzers for both code and documentation. Once you're done with your changes, submit a pull request.

Coditsu will automatically check your work against our quality standards. You can find your commit check results on the [builds page](https://app.coditsu.io/karafka/repositories/envlogic/builds/commit_builds) of Envlogic repository.

[![coditsu](https://coditsu.io/assets/quality_bar.svg)](https://app.coditsu.io/karafka/repositories/envlogic/builds/commit_builds)
