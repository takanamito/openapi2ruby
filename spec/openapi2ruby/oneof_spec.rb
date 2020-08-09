require 'spec_helper'

require 'fileutils'

RSpec.describe Openapi2ruby::Generator do
  let(:generator) { Openapi2ruby::Generator.new(schema) }
  let(:schema) { Openapi2ruby::Parser.parse(schema_path).schemas.first }
  let(:schema_path) { 'spec/fixtures/files/oneof.yaml' }
  let(:output_path) { 'spec/tmp' }

  describe '#generate' do
    let(:generated_file) { "#{output_path}/pet_serializer.rb" }
    let(:file_fixture) { 'spec/fixtures/files/pet_serializer_oneof.rb' }

    before { generator.generate(output_path, nil) }

    it 'generates serializer class' do
      expect(File.exist?(generated_file)).to be true
      expect(FileUtils.cmp(generated_file, file_fixture)).to be true
    end
  end
end
