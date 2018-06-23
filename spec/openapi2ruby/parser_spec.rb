require 'spec_helper'

RSpec.describe Openapi2ruby::Parser do
  subject { Openapi2ruby::Parser.new(path) }

  let(:path) { 'spec/fixtures/files/petstore.yaml' }

  describe '#parse_file' do
    it 'returns parsed from openapi.yaml hash' do
      expect(subject.parse_file['openapi']).to eq '3.0.0'
    end
  end

  describe '#parse' do
    it 'returns Openapi instance' do
      expect(subject.parse).to be_a Openapi2ruby::Openapi
    end
  end

  describe '.parse' do
    subject { Openapi2ruby::Parser.parse(path) }

    it { is_expected.to be_a Openapi2ruby::Openapi }
  end
end
