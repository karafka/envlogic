require 'spec_helper'

RSpec.describe Envlogic::Env do
  using Envlogic::StringRefinements

  let(:test_class) { ClassBuilder.build }

  subject { described_class.new(test_class) }

  describe '#initialize' do
    context 'when we dont have any ENVs that we can use' do
      before do
        expect(ENV)
          .to receive(:[])
          .at_least(3).times
          .and_return(nil)

        expect_any_instance_of(described_class)
          .to receive(:app_dir_name)
          .and_return(rand.to_s)
      end

      it 'should use FALLBACK_ENV' do
        expect(subject).to eq described_class::FALLBACK_ENV
      end
    end

    context 'when app_dir_name env key env is set' do
      let(:env_value) { rand.to_s }

      before do
        expect_any_instance_of(described_class)
          .to receive(:app_dir_name)
          .exactly(:once)
          .and_return('envlogic')

        expect(ENV)
          .to receive(:[])
          .with('ENVLOGIC_ENV')
          .and_return(env_value)
      end

      it 'should use it' do
        expect(subject).to eq env_value
      end
    end

    context 'when class name env is set' do
      let(:env_value) { rand.to_s }

      before do
        expect_any_instance_of(described_class)
          .to receive(:app_dir_name)
          .exactly(:once)
          .and_return('envlogic')

        expect(ENV)
          .to receive(:[])
          .and_return(nil, env_value)
      end

      it 'should use it' do
        expect(subject).to eq env_value
      end
    end

    context 'when FALLBACK_ENV_KEY value is set' do
      let(:env_value) { rand.to_s }

      before do
        expect_any_instance_of(described_class)
          .to receive(:app_dir_name)
          .exactly(:once)
          .and_return('envlogic')

        expect(ENV)
          .to receive(:[])
          .and_return(nil, nil, env_value)
      end

      it 'should use it' do
        expect(subject).to eq env_value
      end
    end
  end

  describe '#update' do
    let(:new_env) { rand.to_s }

    it 'should replace self with inquired new value' do
      expect(subject)
        .to receive(:replace)
        .with(
          ActiveSupport::StringInquirer.new(new_env)
        )

      subject.update(new_env)
    end
  end

  describe '#app_dir_name' do
    let(:pathname) { double }
    let(:dir_name) { double }

    before { subject }

    it 'should get a basename from dirname' do
      expect(Pathname)
        .to receive(:new)
        .with(ENV['BUNDLE_GEMFILE'])
        .and_return(pathname)

      expect(pathname)
        .to receive_message_chain(:dirname, :basename, :to_s)
        .and_return(dir_name)

      expect(subject.send(:app_dir_name)).to eq dir_name
    end
  end

  %w( production test development ).each do |env|
    context "environment: #{env}" do
      before { subject.update(env) }

      it { expect(subject.public_send(:"#{env}?")).to eq true }
    end
  end
end
