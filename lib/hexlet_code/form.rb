# frozen_string_literal: true

# autoload :Input, "#{PATH}/hexlet_code/input"

require_relative './input'

module HexletCode
  class Form
    attr_accessor :type, :attrs, :object, :fields

    def initialize(object, attrs = {}, &block)
      @object = object
      @attrs = attrs
      @fields = []

      block.call(self) if block_given?
    end

    def input(key, options = {})
      value = @object.public_send(key)

      @fields << if options[:as]&.to_sym == :text
                   Input.new(:textarea, { name: key, value: }.merge(options))
                 else
                   Input.new(:input, { name: key, type: 'text', value: }.merge(options))
                 end
    end

    def submit(value = 'Save')
      @fields << Input.new(:input, { type: 'submit', value:, label: false })
    end
  end
end
