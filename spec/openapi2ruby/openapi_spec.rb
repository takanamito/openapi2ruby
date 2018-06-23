require 'spec_helper'

RSpec.describe Openapi2ruby::Openapi do
  subject { Openapi2ruby::Openapi.new(content) }

  let(:path) { 'spec/fixtures/files/petstore.yaml' }
  let(:content) { YAML.load(File.read(path)) }

  describe '#schemas' do
    it 'returns Openapi::Schema array' do
      expect(subject.schemas).to all be_an(Openapi2ruby::Openapi::Schema)
    end
  end
end
