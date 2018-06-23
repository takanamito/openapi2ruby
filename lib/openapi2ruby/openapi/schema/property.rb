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

    def ref
      return @items['$ref'].split('/').last if ref_items?
      @ref.split('/').last
    end

    def ref_class
      ref.camelcase
    end

    def ref?
      !@ref.nil?
    end

    def ref_items?
      @type == 'array' && !@items['$ref'].nil?
    end

    def types
      return [ref] if @type.nil?
      converted_types
    end

    private

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
