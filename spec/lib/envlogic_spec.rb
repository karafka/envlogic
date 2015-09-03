require 'spec_helper'

RSpec.describe Envlogic do
  subject do
    ClassBuilder.build do
      extend Envlogic
    end
  end

  describe '#env' do
    before { subject.instance_variable_set(:'@env', env) }

    context 'when env is not yet set' do
      let(:env) { nil }

      it 'should create envlogic env instance and return it' do
        expect(subject.env).to be_a described_class::Env
      end
    end

    context 'when env is set' do
      let(:env) { double }

      it 'should return it' do
        expect(subject.env).to eq env
      end
    end
  end

  describe '#env=' do
    let(:stringified_env) { double }
    let(:new_env) { double(to_s: stringified_env) }

    it 'should execute update on env' do
      expect(subject.env)
        .to receive(:update)
        .with(stringified_env)

      subject.env = new_env
    end
  end
end
