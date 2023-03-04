# frozen_string_literal: true

module HexletCode
  class Form
    attr_accessor :attrs, :object, :fields

    def initialize(object, attrs = {}, &block)
      @object = object
      @attrs = attrs
      @fields = []

      block.call(self) if block_given?
    end

    def input(key, options = {})
      value = @object.public_send(key)
      @fields << { name: key, value: }.merge(options)
    end

    def submit(value = 'Save', options = {})
      @fields << { type: 'submit', value:, label: false }.merge(options)
    end
  end
end
