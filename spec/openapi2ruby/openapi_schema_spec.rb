require 'spec_helper'

RSpec.describe Openapi2ruby::Openapi::Schema do
  subject { openapi.schemas.first }

  let(:path) { 'spec/fixtures/files/petstore.yaml' }
  let(:content) { YAML.load(File.read(path)) }
  let(:openapi) { Openapi2ruby::Openapi.new(content) }

  describe '#name' do
    it 'returns camelcase schema name' do
      expect(subject.name).to eq 'Pet'
    end
  end

  describe '#requires' do
    it 'returns required fields' do
      expect(subject.requireds).to eq %w(id name)
    end
  end

  describe '#properties' do
    it 'returns Openapi::Schema::Property instances' do
      expect(subject.properties).to all be_an(Openapi2ruby::Openapi::Schema::Property)
    end
  end

  describe '#required?' do
    subject { schema.required?(property) }

    let(:schema) { openapi.schemas.first }

    context 'when required property' do
      let(:property) { schema.properties.first }

      it { is_expected.to be true }
    end

    context 'when not be required property' do
      let(:property) do
        Openapi2ruby::Openapi::Schema::Property.new(
          { name: 'hoge', definition: {} }
        )
      end

      it { is_expected.to be false }
    end
  end
end
