require 'active_support/string_inquirer'

# Main module
module EnvLogic
  # Env module to get and set environment
  module Env
    # Returns the current Application environment.
    # @example
    #   App.env # => 'development'
    #   App.env.development? # => true
    #   App.env.production? # => false
    def env
      env = EnvLogic.app_env(self) || ENV['RACK_ENV'] || 'development'
      @env ||= ActiveSupport::StringInquirer.new(env)
    end

    # Sets the Application environment.
    # @example
    #   App.env = 'staging' # => "staging"
    def env=(environment)
      @env = ActiveSupport::StringInquirer.new(environment)
    end
  end
end
