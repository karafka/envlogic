# frozen_string_literal: true
module Envlogic
  # String refinements used in this library
  module StringRefinements
    # Postfix for ENV keys
    ENV_KEY_POSTFIX = '_ENV'

    refine String do
      # Converts any string into a bash ENV key
      def to_env_key
        underscore
          .tr('/', '_')
          .upcase + Envlogic::StringRefinements::ENV_KEY_POSTFIX
      end
    end
  end
end
