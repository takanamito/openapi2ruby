module Openapi2ruby
  class Openapi::Schema
    def initialize(content)
      @name = content[:name]
      @definition = content[:definition]
    end

    # OpenAPI camelcase schema name
    # @return [String]
    def name
      @name.camelcase
    end

    # OpenAPI required properties name
    # @return [Array[String]]
    def requireds
      @definition['required']
    end

    # OpenAPI schema properties
    # @return [Array[Openapi2ruby::Openapi::Schema]]
    def properties
      return [] if @definition['properties'].nil?
      @definition['properties'].each_with_object([]) do |(key, value), results|
        content = { name: key, definition: value }
        results << Openapi2ruby::Openapi::Schema::Property.new(content)
      end
    end

    # Whether property is required or not
    # @param [Openapi2ruby::Openapi::Schema::Property] OpenAPI schema property
    # @return [Boolean]
    def required?(property)
      return false if requireds.nil?
      requireds.include?(property.name)
    end

    def one_ofs
      return [] if properties.empty?
      properties.each_with_object([]) do |value, results|
        if value.one_of?
          results << value.one_of_refs
        else
          results
        end
      end
    end
  end
end
