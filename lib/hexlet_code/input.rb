# frozen_string_literal: true

module HexletCode
  class Input
    attr_accessor :type, :attrs

    def initialize(type = :input, attrs = {})
      @type = type
      @attrs = attrs
    end
  end
end
