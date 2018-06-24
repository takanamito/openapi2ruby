require 'yaml'

module Openapi2ruby
  class Parser
    # Parse openapi.yaml
    # @param path [String] OpenAPI schema file path
    # @return [Openapi2ruby::Openapi]
    def self.parse(path)
      new(path).parse
    end

    def initialize(path)
      @path = path
    end

    # Parse openapi.yaml
    # @return [Openapi2ruby::Openapi]
    def parse
      Openapi.new(parse_file)
    end

    def parse_file
      file = File.read(@path)
      YAML.load(file)
    end
  end
end
