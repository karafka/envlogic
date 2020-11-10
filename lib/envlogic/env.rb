# frozen_string_literal: true

# Main module
module Envlogic
  # Env module to get and set environment
  class Env < String
    # What environment key should be used by default
    FALLBACK_ENV_KEY = 'RACK_ENV'
    # What default environment should be assumed when there's nothing else
    FALLBACK_ENV = 'development'
    # Postfix for ENV keys
    ENV_KEY_POSTFIX = '_ENV'
    # String inflecting engine
    INFLECTOR = Dry::Inflector.new

    private_constant :FALLBACK_ENV_KEY, :FALLBACK_ENV, :ENV_KEY_POSTFIX, :INFLECTOR

    # It's just a string replace alias for the envlogic compatibility
    alias update replace

    # @param klass [Class, Module] class/module for which we want to build a Envlogic::Env object
    # @return [Envlogic::Env] envlogic env object]
    # @note Will load appropriate environment automatically
    # @example
    #   Envlogic::Env.new(User)
    def initialize(klass)
      super('')

      env = ENV[to_env_key(app_dir_name)]
      env ||= ENV[to_env_key(klass.to_s)]
      env ||= ENV[FALLBACK_ENV_KEY]

      update(env || FALLBACK_ENV)
    end

    # @param method_name [String] method name
    # @param include_private [Boolean] should we include private methods as well
    # @return [Boolean] true if we respond to a given missing method, otherwise false
    def respond_to_missing?(method_name, include_private = false)
      (method_name[-1] == '?') || super
    end

    # Reacts to missing methods, from which some might be the env checks.
    # If the method ends with '?' we assume, that it is an env check
    # @param method_name [String] method name for missing or env name with question mark
    # @param arguments [Array] any arguments that we pass to the method
    def method_missing(method_name, *arguments)
      method_name[-1] == '?' ? self == method_name[0..-2] : super
    end

    private

    # @return [String] name of the directory in which this application is
    # @note Will return only the last part, so if the dir is /home/apps/my_app it will
    #   only return the 'my_app' part
    def app_dir_name
      Pathname
        .new(ENV['BUNDLE_GEMFILE'])
        .dirname
        .basename
        .to_s
    end

    # Converts any string into a bash ENV key
    # @param string [String] string we want to convert into an env key
    # @return [String] converted name that can be an ENV key
    def to_env_key(string)
      INFLECTOR
        .underscore(string)
        .tr('/', '_')
        .upcase + ENV_KEY_POSTFIX
    end
  end
end
