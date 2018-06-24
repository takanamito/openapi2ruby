module Openapi2ruby
  class Openapi::Schema::Property
    attr_reader :name

    def initialize(content)
      @name = content[:name]
      @type = content[:definition]['type']
      @items = content[:definition]['items']
      @format = content[:definition]['format']
      @ref = content[:definition]['$ref']
    end

    # OpenAPI schema ref property name
    # @return [String]
    def ref
      return @items['$ref'].split('/').last if ref_items?
      @ref.split('/').last
    end

    # OpenAPI schema ref property class name
    # @return [String]
    def ref_class
      ref.camelcase
    end

    # Whether property is ref or not
    # @return [Boolean]
    def ref?
      !@ref.nil?
    end

    # Whether property has ref array items
    # @return [Boolean]
    def ref_items?
      @type == 'array' && !@items['$ref'].nil?
    end

    # OpenAPI schema property types
    # @return [Array[Class]]
    def types
      return [ref] if @type.nil?
      converted_types
    end

    private

    # OpenAPI schema property types in Ruby
    # @return [Array[Class]]
    def converted_types
      case @type
      when 'string', 'integer', 'array'
        [Object.const_get(@type.capitalize)]
      when 'number'
        [Float]
      when 'boolean'
        [TrueClass, FalseClass]
      when 'object'
        [Hash]
      end
    end
  end
end
