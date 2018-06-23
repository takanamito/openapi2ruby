module Openapi2ruby
  class Openapi::Schema
    def initialize(content)
      @name = content[:name]
      @definition = content[:definition]
    end

    def name
      @name.camelcase
    end

    def requireds
      @definition['required']
    end

    def properties
      return [] if @definition['properties'].nil?
      @definition['properties'].each_with_object([]) do |(key, value), results|
        content = { name: key, definition: value }
        results << Openapi2ruby::Openapi::Schema::Property.new(content)
      end
    end

    def required?(property)
      return false if requireds.nil?
      requireds.include?(property.name)
    end
  end
end
