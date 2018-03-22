# frozen_string_literal: true

%w[
  dry/inflector
  envlogic/version
  envlogic/env
].each { |lib| require lib }

# Main module that encapsulates logic that should be used to extend any class/module
# @note This module should be extended into the class/module in which we want to have env support
# @example Use it in RandomClass class
#   class RandomClass
#     extend Envlogic
#   end
#
# RandomClass.env #=> Envlogic::Env instance
# RandomClass.env.production? #=> false
# RandomClass.env.development? #=> true
module Envlogic
  # @return [Envlogic::Env] envlogic env instance that allows us to check environment
  # @example Invoke env in TestClass
  #   TestClass.env #=> Envlogic::Env instance
  def env
    @env ||= Envlogic::Env.new(self)
  end

  # @param environment [String, Symbol] new environment that we want to set
  # @return [Envlogic::Env] envlogic env instance
  # @example Assign new environment to MyApp
  #   MyApp.env = :production
  def env=(environment)
    env.update(environment.to_s)
  end

  # We alias this for backword compatibility with some code that uses full names
  alias environment env
  alias environment= env=
end
