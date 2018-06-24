module Openapi2ruby
  class Openapi
    def initialize(content)
      @content = content
    end

    # Creates OpenAPI Schema array
    # @return [Array[Openapi2ruby::Openapi::Schema]]
    def schemas
      @content['components']['schemas'].each_with_object([]) do |(key, value), results|
        schema_content = { name: key, definition: value}
        schema = Openapi2ruby::Openapi::Schema.new(schema_content)
        results << schema unless schema.properties.empty?
      end
    end
  end
end
