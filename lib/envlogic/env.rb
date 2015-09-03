# Main module
module Envlogic
  # Env module to get and set environment
  module Env
    # What environment key should be used by default
    FALLBACK_ENV_KEY = 'RACK_ENV'
    # What default environment should be asumed when there's nothing else
    FALLBACK_ENV = 'development'

    # Returns the current Application environment.
    # @example
    #   App.env # => 'development'
    #   App.env.development? # => true
    #   App.env.production? # => false
    def env
      @envlogic_env ||= ActiveSupport::StringInquirer.new(
        Envlogic.app_env(self) || ENV[FALLBACK_ENV_KEY] || FALLBACK_ENV
      )
    end

    # Sets the Application environment.
    # @example
    #   App.env = 'staging' # => "staging"
    def env=(environment)
      @envlogic_env = ActiveSupport::StringInquirer.new(environment)
    end
  end
end
