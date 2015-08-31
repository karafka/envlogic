# EnvLogic
Envlogic is a library used to manage environments for your Ruby application

## Installation

Add gem to your Gemfile
```ruby
  gem 'env-logic'
```

## Usage

Require env_logic in your app

```ruby
  require 'env_logic'
```
Extend *EnvLogic::Env* class into the class or module where you want to set
and get *env* variable.

```ruby
module Karafka
  extend EnvLogic::Env

  # code of Karafka module
end
```

After adding the code above Karafka module will have *env* and *env=* methods.

```ruby
  Karafka.env = development
  Karafka.env.development? # => true
  Karafka.env.production? # => false
```

Default environment value is get from ENV variables which are set by developer
or ENV['RACK_ENV']. Otherwise default value is development.

### ENV variables which are set by developer

By default gem is looking for ENV with *'APP_NAME_ENV'*
e.g. If app name is facebook-api it will search environment in
ENV['FACEBOOK_API_ENV'].

```ruby
ENV['FACEBOOK_API_ENV'] = 'production'
Karafka.env.production? # => true

```

Otherwise it looks in env which is build from class where you add Env logic:


```ruby
module Basic
  module Karafka
    extend EnvLogic::Env

    # code of Karafka module
  end
end

```

```ruby
ENV['FACEBOOK_API_ENV'] = nil
ENV['BASIC_KARAFKA_ENV'] = 'development'

Karafka.env.production? # => false
Karafka.env.development? # => true

```


