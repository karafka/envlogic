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
    ENV[env_value(app_root)] || ENV[env_value(klass.to_s)]
  end

  private

  # Method defines name of ENV
  # @return [String, Class] name of env value
  # @example
  #  EnvLogic.env_value(BasicModule::Karafka) # => 'BASIC_MODULE_KARAFKA_ENV'
  #  EnvLogic.env_value('projects/facebook-api') # => 'FACEBOOK_API_ENV'
  def self.env_value(root)
    "#{app_name(root)}_ENV"
  end

  # Name of gem or application based on path
  def self.app_name(root)
    name = root
      .to_s
      .split('/')
      .last
    demodulize(name)
  end

  # @example EnvLogic.demodulize('A::B::C-CLASS') #=> 'A_B_C_CLASS'
  # @return [String]
  def self.demodulize(name)
    name
      .underscore
      .tr('/', '_')
      .upcase
  end

  # @return [String] app root path
  def self.app_root
    Pathname.new(File.dirname(ENV['BUNDLE_GEMFILE']))
  end
end
