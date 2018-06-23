require 'spec_helper'

RSpec.describe Openapi2ruby::Openapi::Schema::Property do
  let(:path) { 'spec/fixtures/files/link-example.yaml' }
  let(:content) { YAML.load(File.read(path)) }
  let(:openapi) { Openapi2ruby::Openapi.new(content) }
  let(:pull_req_schema) { openapi.schemas.last }
  let(:properties) { pull_req_schema.properties }

  describe '#ref' do
    subject { property.ref }

    let(:property) { properties.last }

    it { is_expected.to eq 'user' }
  end

  describe '#ref_class' do
    subject { property.ref_class }

    let(:property) { properties.last }

    it { is_expected.to eq 'User' }
  end

  describe '#ref?' do
    subject { property.ref? }


    context 'when property has ref type' do
      let(:property) { properties.last }

      it { is_expected.to be true }
    end

    context 'when property has primitive type' do
      let(:property) { properties.first }

      it { is_expected.to be false }
    end
  end

  describe '#ref_items?' do
    subject { property.ref_items? }

    let(:property) { properties.last }

    it { is_expected.to be false }
  end

  describe '#types' do
    subject { properties.first.types }

    it { is_expected.to eq [Integer] }
  end
end
