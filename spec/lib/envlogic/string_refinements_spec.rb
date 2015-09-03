require 'spec_helper'

RSpec.describe Envlogic::StringRefinements do
  using described_class

  let(:postfix) { described_class::ENV_KEY_POSTFIX }

  describe '#to_env_key' do
    context 'when this is a non slash string' do
      let(:string) { SecureRandom.hex }

      it 'should just upcase it and add _ENV' do
        expect(string.to_env_key).to eq string.upcase + postfix
      end
    end

    context 'when this is somekind of modulized string' do
      let(:string) { "#{SecureRandom.hex}::#{SecureRandom.hex}" }

      it 'should should upcase, underscore it and add _ENV' do
        expect(string.to_env_key).to eq string.underscore.upcase.tr('/', '_') + postfix
      end
    end
  end
end
