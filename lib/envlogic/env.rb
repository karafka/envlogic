# frozen_string_literal: true
# Main module
module Envlogic
  # Env module to get and set environment
  class Env < ActiveSupport::StringInquirer
    using StringRefinements

    # What environment key should be used by default
    FALLBACK_ENV_KEY = 'RACK_ENV'
    # What default environment should be asumed when there's nothing else
    FALLBACK_ENV = 'development'

    # @param klass [Class, Module] class/module for which we want to build a Envlogic::Env object
    # @return [Envlogic::Env] envlogic env object]
    # @example
    #   Envlogic::Env.new(User)
    # @note Will load appropriate environment automatically
    def initialize(klass)
      env = ENV[app_dir_name.to_env_key]
      env ||= ENV[klass.to_s.to_env_key]
      env ||= ENV[FALLBACK_ENV_KEY]

      update(env || FALLBACK_ENV)
    end

    # @param environment [String] new environment that we want to set
    # @example
    #   env.update('production')
    def update(environment)
      replace(
        ActiveSupport::StringInquirer.new(environment)
      )
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
  end
end
