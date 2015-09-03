require 'spec_helper'

RSpec.describe Envlogic do
  subject { described_class }

  describe '.app_root' do
    context 'when we want to get app root path' do
      before do
        expect(ENV).to receive(:[]).with('BUNDLE_GEMFILE').and_return('/')
      end

      it { expect(subject.app_root.to_path).to eq '/' }
    end
  end

  describe '.app_env' do
    let(:app_name) { rand.to_s }
    let(:app_env_value) { rand.to_s }

    context 'when we have app root env' do
      before do
        ENV["#{app_name.upcase}_ENV"] = app_env_value
        expect(subject).to receive(:app_root).and_return("path/#{app_name}")
      end

      it { expect(subject.app_env(Object)).to eq app_env_value }
    end
  end
end
