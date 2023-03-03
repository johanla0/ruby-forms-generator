# frozen_string_literal: true

HexletCode.autoload :Input, 'hexlet_code/input.rb'

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
                   HexletCode::Input.new(:textarea, { name: key, value: }.merge(options))
                 else
                   HexletCode::Input.new(:input, { name: key, type: 'text', value: }.merge(options))
                 end
    end

    def submit(value = 'Save')
      @fields << HexletCode::Input.new(:input, { type: 'submit', value:, label: false })
    end
  end
end
