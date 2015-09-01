%w(
  env_logic/version
  env_logic/env
  active_support/inflector
  active_support/string_inquirer
).each { |lib| require lib }

# Main module to encapsulate logic
module EnvLogic
  # Method gets environment of application which use gem.
  # Preference is given for ENV of application if it is set
  #   otherwise we get ENV of class where we extend EnvLogic::Env
  #
  # @param [Class] klass class where we extend EnvLogic::Env
  # @example
  #   If we use this method in Karafka gem it returns ENV of Karafka gem
  #   module Karafka
  #     extend EnvLogic::Env
  #   end
  #   EnvLogic.app_env(Karafka) => ENV['KARAFKA_ENV']
  #
  #   Usage in facebook-api/facebook_api application
  #     module Facebook
  #       class App
  #         extend EnvLogic::Env
  #       end
  #     end
  #     EnvLogic.app_env(App) => ENV['FACEBOOK_APP_ENV']
  #
  #   Or application name if it is set
  #     ENV['FACEBOOK_API_ENV'] = 'development'
  #     EnvLogic.app_env(Karafka) => ENV['FACEBOOK_API_ENV'] => 'development'
  #
  # @return [String] environment value if application name based ENV is set.
  # @return [nil] if ENV variables are not set
  def self.app_env(klass)
    ENV[env_value(app_name)] || ENV[env_value(klass)]
  end

  private

  # @param [Class, String] name Class name or application name which we should be used in ENV name
  # @example
  #   EnvLogic.env_value('A::B::C-CLASS') #=> 'A_B_C_CLASS_ENV'
  #   EnvLogic.env_value(A::B::C-CLASS) #=> 'A_B_C_CLASS_ENV'
  # @return [String]
  def self.env_value(name)
    env_name = name
      .to_s
      .underscore
      .tr('/', '_')
      .upcase
    "#{env_name}_ENV"
  end

  # Get application name of gem or application based on path
  # @example
  #   EnvLogic.app_name('projects/facebook-api') # => 'facebook_api'
  def self.app_name
    app_root
      .to_s
      .split('/')
      .last
  end

  # @return [String] app root path
  def self.app_root
    Pathname.new(File.dirname(ENV['BUNDLE_GEMFILE']))
  end
end
