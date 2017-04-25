# frozen_string_literal: true

RSpec.describe Envlogic::Env do
  using Envlogic::StringRefinements

  subject(:envlogic_env) { described_class.new(test_class) }

  let(:test_class) { ClassBuilder.build }

  describe '#initialize' do
    context 'when we dont have any ENVs that we can use' do
      before { envlogic_env }

      it 'expect to use FALLBACK_ENV' do
        expect(envlogic_env.send(:initialize, test_class)).to eq described_class::FALLBACK_ENV
      end
    end

    context 'when app_dir_name env key env is set' do
      let(:env_value) { rand.to_s }

      before do
        ENV['ENVLOGIC_ENV'] = env_value
        envlogic_env
      end

      after { ENV['ENVLOGIC_ENV'] = nil }

      it 'expect to use it' do
        expect(envlogic_env.send(:initialize, test_class)).to eq env_value
      end
    end

    context 'when class name env is set' do
      let(:test_class) { ClassName = ClassBuilder.build }
      let(:env_value) { rand.to_s }

      before do
        ENV['CLASS_NAME_ENV'] = env_value
        envlogic_env
      end

      after { ENV['CLASS_NAME_ENV'] = env_value }

      it 'expect to use it' do
        expect(envlogic_env.send(:initialize, test_class)).to eq env_value
      end
    end

    context 'when FALLBACK_ENV_KEY value is set' do
      let(:env_value) { rand.to_s }

      before do
        ENV[described_class::FALLBACK_ENV_KEY] = env_value
        envlogic_env
      end

      after { ENV[described_class::FALLBACK_ENV_KEY] = nil }

      it 'expect to use it' do
        expect(envlogic_env.send(:initialize, test_class)).to eq env_value
      end
    end
  end

  describe '#update' do
    let(:new_env) { rand.to_s }

    before do
      envlogic_env
      ENV['CLASS_NAME_ENV'] = new_env
    end

    it 'expect to replace self with inquired new value' do
      envlogic_env.update(new_env)
      expect(envlogic_env).to eq new_env
    end
  end

  describe '#app_dir_name' do
    let(:pathname) { double }
    let(:dir_name) { double }

    before do
      envlogic_env

      expect(Pathname)
        .to receive(:new)
        .with(ENV['BUNDLE_GEMFILE'])
        .and_return(pathname)
    end

    it 'expect to get a basename from dirname' do
      expect(pathname)
        .to receive_message_chain(:dirname, :basename, :to_s)
        .and_return(dir_name)

      expect(envlogic_env.send(:app_dir_name)).to eq dir_name
    end
  end

  %w[
    production test development
  ].each do |env|
    context "environment: #{env}" do
      before { envlogic_env.update(env) }

      it { expect(envlogic_env.public_send(:"#{env}?")).to eq true }
    end
  end
end
