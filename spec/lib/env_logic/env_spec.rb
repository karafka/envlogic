require 'spec_helper'

RSpec.describe EnvLogic::Env do
  let(:path) { Pathname.new(File.join(Dir.pwd, 'lib', 'karafka')) }
  subject do
    ClassBuilder.build do
      def self.to_s
        'BaseModule::TestClass'
      end

      extend EnvLogic::Env
    end
  end

  describe '.env' do
    context 'ENV variables are not set' do
      it { expect(subject.env.development?).to be_truthy }
    end

    context 'RACK_ENV is set' do
      before do
        expect(EnvLogic).to receive(:app_root) { path }
        expect(ENV).to receive(:[])
          .with('BASE_MODULE_TEST_CLASS_ENV') { nil }
        expect(ENV).to receive(:[])
          .with('KARAFKA_ENV') { nil }
        allow(ENV).to receive(:[])
          .with('RACK_ENV') { 'test' }
      end
      it { expect(subject.env.test?).to be_truthy }
    end

    context 'application name based env is set' do
      before do
        expect(EnvLogic).to receive(:app_root) { path }
        expect(ENV).to receive(:[])
          .with('KARAFKA_ENV') { 'production' }
        ENV['RACK_ENV'] = 'test'
      end
      it { expect(subject.env.production?).to be_truthy }
    end

    context 'class name based env is set' do
      before do
        expect(EnvLogic).to receive(:app_root) { path }
        expect(ENV).to receive(:[])
          .with('KARAFKA_ENV') { nil }
        expect(ENV).to receive(:[])
          .with('BASE_MODULE_TEST_CLASS_ENV') { 'test_class_env' }
        ENV['RACK_ENV'] = 'test'
      end

      it { expect(subject.env.test_class_env?).to be_truthy }
    end
  end

  describe 'env=' do
    before do
      subject.env = 'production'
    end

    it { expect(subject.env.production?).to be_truthy }
    it { expect(subject.env.staging?).to be_falsey }
  end
end
