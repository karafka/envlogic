# frozen_string_literal: true

RSpec.describe Envlogic do
  subject(:envlogic) do
    extended = described_class

    ClassBuilder.build do
      extend extended
    end
  end

  describe '#env' do
    before { envlogic.instance_variable_set(:'@env', env) }

    context 'when env is not yet set' do
      let(:env) { nil }

      it 'expect to create envlogic env instance and return it' do
        expect(envlogic.env).to be_a described_class::Env
      end
    end

    context 'when env is set' do
      let(:env) { double }

      it 'expect to return it' do
        expect(envlogic.env).to eq env
      end
    end
  end

  describe '#env=' do
    let(:stringified_env) { double }
    let(:new_env) { instance_double(Envlogic::Env, to_s: stringified_env) }

    it 'expect to execute update on env' do
      expect(envlogic.env)
        .to receive(:update)
        .with(stringified_env)

      envlogic.env = new_env
    end
  end
end
